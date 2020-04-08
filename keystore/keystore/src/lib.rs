use bip39::{Language, Mnemonic, MnemonicType};
use blockies::Ethereum;
use image::{ImageFormat, Rgba, RgbaImage};
use qrcode::QrCode;
use rand::rngs::OsRng;
use rand::RngCore;
use serde::{Deserialize, Serialize};
use sp_core::crypto::{Pair as _, Public, Ss58Codec};
use sp_core::sr25519::Pair;
use std::fs::File;
use std::io::Cursor;
use std::path::{Path, PathBuf};
use strobe_rs::{SecParam, Strobe};

#[derive(Debug)]
pub enum Error {
    ConfigDirNotFound,
    KeyLoaded,
    KeyExists,
    KeyNotFound,
    Io(std::io::Error),
    Json(serde_json::Error),
    Auth(strobe_rs::AuthError),
    Fail(failure::Error),
    Blocky(pixelate::Error),
    Qr(qrcode::types::QrError),
    Img(image::ImageError),
}

impl std::fmt::Display for Error {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        let msg = match self {
            Error::ConfigDirNotFound => "Config directory wasn't found.",
            Error::KeyLoaded => "Key is already loaded.",
            Error::KeyExists => "A key exists.",
            Error::KeyNotFound => "No key was found.",
            Error::Io(error) => return error.fmt(f),
            Error::Json(error) => return error.fmt(f),
            Error::Auth(_) => "Mac integrity check failed.",
            Error::Fail(error) => return error.fmt(f),
            Error::Blocky(error) => return write!(f, "{:?}", error),
            Error::Qr(error) => return error.fmt(f),
            Error::Img(error) => return error.fmt(f),
        };
        write!(f, "{}", msg)
    }
}

impl std::error::Error for Error {}

impl From<std::io::Error> for Error {
    fn from(error: std::io::Error) -> Self {
        Self::Io(error)
    }
}

impl From<serde_json::Error> for Error {
    fn from(error: serde_json::Error) -> Self {
        Self::Json(error)
    }
}

impl From<strobe_rs::AuthError> for Error {
    fn from(error: strobe_rs::AuthError) -> Self {
        Self::Auth(error)
    }
}

impl From<failure::Error> for Error {
    fn from(error: failure::Error) -> Self {
        Self::Fail(error)
    }
}

impl From<pixelate::Error> for Error {
    fn from(error: pixelate::Error) -> Self {
        Self::Blocky(error)
    }
}

impl From<qrcode::types::QrError> for Error {
    fn from(error: qrcode::types::QrError) -> Self {
        Self::Qr(error)
    }
}

impl From<image::ImageError> for Error {
    fn from(error: image::ImageError) -> Self {
        Self::Img(error)
    }
}

fn keyfile_path() -> Result<PathBuf, Error> {
    if let Some(dir) = dirs::config_dir() {
        Ok(dir.join("flutter-keystore-plugin").join("keyfile"))
    } else {
        Err(Error::ConfigDirNotFound)
    }
}

#[derive(Clone, Debug, Deserialize, Serialize)]
struct KeyFile {
    mac: [u8; 16],
    nonce: [u8; 24],
    entropy: Vec<u8>,
    paper_backup: bool,
}

impl KeyFile {
    pub fn read_from(path: &Path) -> Result<Self, Error> {
        let file = File::open(path)?;
        Ok(serde_json::from_reader(file)?)
    }

    pub fn write_to(&self, path: &Path) -> Result<(), Error> {
        std::fs::create_dir_all(path.parent().unwrap())?;
        let file = File::create(path)?;
        #[cfg(unix)]
        {
            use std::fs::Permissions;
            use std::os::unix::fs::PermissionsExt;
            file.set_permissions(Permissions::from_mode(0o600))?;
        }
        Ok(serde_json::to_writer(file, self)?)
    }

    pub fn from_entropy(entropy: &[u8], password: &str) -> Self {
        let mut s = Strobe::new(b"flutter-keystore-plugin", SecParam::B128);

        // absorb nonce
        let mut nonce = [0u8; 24];
        OsRng.fill_bytes(&mut nonce);
        s.ad(&mut nonce, false);

        // absorb password
        s.ad(password.as_bytes(), false);

        // encrypt entropy
        let mut entropy = entropy.to_owned();
        s.send_enc(&mut entropy, false);

        // integrity check
        let mut mac = [0u8; 16];
        s.send_mac(&mut mac, false);

        Self {
            mac,
            nonce,
            entropy,
            paper_backup: false,
        }
    }

    pub fn into_entropy(self, password: &str) -> Result<Vec<u8>, Error> {
        let mut s = Strobe::new(b"flutter-keystore-plugin", SecParam::B128);

        // absorb nonce
        s.ad(&self.nonce, false);

        // absorb password
        s.ad(password.as_bytes(), false);

        // decrypt entropy
        let mut entropy = self.entropy;
        s.recv_enc(&mut entropy, false);

        // check integrity
        let mut mac = self.mac;
        s.recv_mac(&mut mac, false)?;

        Ok(entropy)
    }

    pub fn paper_backup(&self) -> bool {
        self.paper_backup
    }

    pub fn set_paper_backup(&mut self, paper_backup: bool) {
        self.paper_backup = paper_backup;
    }
}

pub enum Status {
    Uninitialized,
    Locked,
    Unlocked,
}

pub struct Keystore {
    path: PathBuf,
    keyfile: Option<KeyFile>,
    keys: Vec<Pair>,
}

impl Default for Keystore {
    fn default() -> Self {
        Self::new(keyfile_path().unwrap())
    }
}

impl Keystore {
    pub fn new(path: PathBuf) -> Self {
        Keystore {
            path,
            keyfile: None,
            keys: Default::default(),
        }
    }

    pub fn status(&self) -> Status {
        if self.keys.len() > 0 {
            return Status::Unlocked;
        }
        if self.path.exists() {
            Status::Locked
        } else {
            Status::Uninitialized
        }
    }

    fn add_key(&mut self, entropy: &[u8], password: &str) -> Result<(), Error> {
        if self.keys.len() > 0 {
            return Err(Error::KeyLoaded);
        }

        let (pair, _seed) = Pair::from_entropy(entropy, Some(password));
        self.keys.push(pair);

        Ok(())
    }

    fn create_key_file(
        &mut self,
        mnemonic: &Mnemonic,
        password: &str,
        paper_backup: bool,
    ) -> Result<(), Error> {
        if self.path.exists() {
            return Err(Error::KeyExists);
        }

        let mut keyfile = KeyFile::from_entropy(mnemonic.entropy(), password);
        keyfile.set_paper_backup(paper_backup);
        keyfile.write_to(&self.path)?;
        self.keyfile = Some(keyfile);

        Ok(())
    }

    fn read_key_file(&mut self, password: &str) -> Result<Vec<u8>, Error> {
        if !self.path.exists() {
            return Err(Error::KeyNotFound);
        }

        let keyfile = KeyFile::read_from(&self.path)?;
        self.keyfile = Some(keyfile.clone());
        Ok(keyfile.into_entropy(password)?)
    }

    pub fn generate(&mut self, password: &str) -> Result<(), Error> {
        let mnemonic = Mnemonic::new(MnemonicType::Words12, Language::English);
        self.create_key_file(&mnemonic, password, false)?;
        self.add_key(mnemonic.entropy(), password)?;
        Ok(())
    }

    pub fn import(&mut self, phrase: &str, password: &str) -> Result<(), Error> {
        let mnemonic = Mnemonic::from_phrase(phrase, Language::English)?;
        self.create_key_file(&mnemonic, password, true)?;
        self.add_key(mnemonic.entropy(), password)?;
        Ok(())
    }

    pub fn unlock(&mut self, password: &str) -> Result<(), Error> {
        if self.keys.len() > 0 {
            return Ok(());
        }
        let entropy = self.read_key_file(password)?;
        self.add_key(&entropy, password)?;
        Ok(())
    }

    pub fn lock(&mut self) {
        self.keys.clear();
    }

    pub fn get_key(&self, key: Option<usize>) -> Result<&Pair, Error> {
        let index = key.unwrap_or_default();
        self.keys.get(index).ok_or(Error::KeyNotFound)
    }

    pub fn paper_backup(&self) -> Result<bool, Error> {
        if let Some(keyfile) = &self.keyfile {
            Ok(keyfile.paper_backup())
        } else {
            Err(Error::KeyNotFound)
        }
    }

    pub fn set_paper_backup(&mut self) -> Result<(), Error> {
        if let Some(keyfile) = &mut self.keyfile {
            keyfile.set_paper_backup(true);
            keyfile.write_to(&self.path)?;
            Ok(())
        } else {
            Err(Error::KeyNotFound)
        }
    }

    pub fn phrase(&self, password: &str) -> Result<String, Error> {
        if let Some(keyfile) = &self.keyfile {
            let entropy = keyfile.clone().into_entropy(password)?;
            let mnemonic = Mnemonic::from_entropy(&entropy, Language::English)?;
            Ok(mnemonic.phrase().to_owned())
        } else {
            Err(Error::KeyNotFound)
        }
    }
}

pub trait PairExt {
    fn ss58(&self) -> String;

    fn identicon(&self) -> Result<RgbaImage, Error>;

    fn qrcode(&self) -> Result<RgbaImage, Error>;
}

impl PairExt for Pair {
    fn ss58(&self) -> String {
        self.public().to_ss58check()
    }

    fn identicon(&self) -> Result<RgbaImage, Error> {
        let blockies = Ethereum::default();
        let mut png = Vec::new();
        let public = self.public();
        blockies.create_icon(&mut png, public.as_slice())?;
        let cursor = Cursor::new(png);
        let img = image::load(cursor, ImageFormat::PNG)?.to_rgba();
        Ok(img)
    }

    fn qrcode(&self) -> Result<RgbaImage, Error> {
        let public = self.public();
        let code = QrCode::new(public.as_slice())?;
        let img = code.render::<Rgba<u8>>().build();
        Ok(img)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use tempdir::TempDir;

    #[test]
    fn test_key_roundtrip() {
        let tmp = TempDir::new("keystore").unwrap();
        let path = tmp.path().join("keyfile");
        let keyfile = KeyFile::from_entropy(b"hello world", "password");
        keyfile.write_to(&path).unwrap();
        let new_keyfile = KeyFile::read_from(&path).unwrap();
        let entropy = new_keyfile.into_entropy("password").unwrap();
        assert_eq!(entropy, b"hello world");
    }

    #[test]
    fn test_import_phrase_roundtrip() {
        let tmp = TempDir::new("keystore").unwrap();
        let path = tmp.path().join("keyfile");
        let mut keystore = Keystore::new(path);
        let mnemonic = Mnemonic::new(MnemonicType::Words12, Language::English);
        keystore.import(mnemonic.phrase(), "password").unwrap();
        let phrase = keystore.phrase("password").unwrap();
        assert_eq!(phrase, mnemonic.phrase());
    }

    #[test]
    fn test_generate_unlock_roundtrip() {
        let tmp = TempDir::new("keystore").unwrap();
        let path = tmp.path().join("keyfile");
        let mut keystore1 = Keystore::new(path.clone());
        keystore1.generate("password").unwrap();
        let mut keystore2 = Keystore::new(path);
        let res = keystore2.unlock("password");
        assert!(res.is_ok());
    }

    #[test]
    fn test_password_missmatch() {
        let tmp = TempDir::new("keystore").unwrap();
        let path = tmp.path().join("keyfile");
        let mut keystore1 = Keystore::new(path.clone());
        keystore1.generate("password").unwrap();
        let mut keystore2 = Keystore::new(path);
        let res = keystore2.unlock("wrong password");
        assert!(res.is_err());
    }
}
