use ffi_helpers::null_pointer_check;
use keystore::{Keystore, PairExt, Status};
use std::ffi::{CStr, CString};
use std::os::raw;
use std::path::Path;

macro_rules! error {
    ($result:expr) => {
        error!($result, 0);
    };
    ($result:expr, $error:expr) => {
        match $result {
            Ok(value) => value,
            Err(e) => {
                ffi_helpers::update_last_error(e);
                return $error;
            }
        }
    };
}

macro_rules! cstr {
    ($ptr:expr) => {
        cstr!($ptr, 0);
    };
    ($ptr:expr, $error:expr) => {
        error!(CStr::from_ptr($ptr).to_str(), $error)
    };
}

#[no_mangle]
pub unsafe extern "C" fn last_error_length() -> i32 {
    ffi_helpers::error_handling::last_error_length()
}

#[no_mangle]
pub unsafe extern "C" fn error_message_utf8(buf: *mut raw::c_char, length: i32) -> i32 {
    ffi_helpers::error_handling::error_message_utf8(buf, length)
}

#[no_mangle]
pub unsafe extern "C" fn keystore_new() -> *mut raw::c_void {
    let keystore = Keystore::default();
    let boxed_keystore = Box::new(keystore);
    Box::into_raw(boxed_keystore) as *mut _
}

#[no_mangle]
pub unsafe extern "C" fn keystore_from_keyfile(path: *const raw::c_char) -> *mut raw::c_void {
    let path = cstr!(path, std::ptr::null_mut());
    let path = Path::new(path).to_path_buf();
    let keystore = Keystore::new(path);
    let boxed_keystore = Box::new(keystore);
    Box::into_raw(boxed_keystore) as *mut _
}

#[no_mangle]
pub unsafe extern "C" fn keystore_destroy(keystore: *mut raw::c_void) {
    null_pointer_check!(keystore);
    Box::from_raw(keystore as *mut Keystore);
}

pub const KEYSTORE_UNINITIALIZED: i32 = 1;
pub const KEYSTORE_LOCKED: i32 = 2;
pub const KEYSTORE_UNLOCKED: i32 = 3;

#[no_mangle]
pub unsafe extern "C" fn keystore_status(keystore: *const raw::c_void) -> i32 {
    null_pointer_check!(keystore);
    let keystore = &*(keystore as *const Keystore);
    match keystore.status() {
        Status::Uninitialized => KEYSTORE_UNINITIALIZED,
        Status::Locked => KEYSTORE_LOCKED,
        Status::Unlocked => KEYSTORE_UNLOCKED,
    }
}

#[no_mangle]
pub unsafe extern "C" fn keystore_generate(
    keystore: *mut raw::c_void,
    password: *const raw::c_char,
) -> i32 {
    null_pointer_check!(keystore);
    let keystore = &mut *(keystore as *mut Keystore);
    let password = cstr!(password);
    let result = keystore.generate(password);
    error!(result);
    1
}

#[no_mangle]
pub unsafe extern "C" fn keystore_import(
    keystore: *mut raw::c_void,
    phrase: *const raw::c_char,
    password: *const raw::c_char,
) -> i32 {
    null_pointer_check!(keystore);
    let keystore = &mut *(keystore as *mut Keystore);
    let phrase = cstr!(phrase);
    let password = cstr!(password);
    let result = keystore.import(phrase, password);
    error!(result);
    1
}

#[no_mangle]
pub unsafe extern "C" fn keystore_unlock(
    keystore: *mut raw::c_void,
    password: *const raw::c_char,
) -> i32 {
    null_pointer_check!(keystore);
    let keystore = &mut *(keystore as *mut Keystore);
    let password = cstr!(password);
    let result = keystore.unlock(password);
    error!(result);
    1
}

#[no_mangle]
pub unsafe extern "C" fn keystore_lock(keystore: *mut raw::c_void) -> i32 {
    null_pointer_check!(keystore);
    let keystore = &mut *(keystore as *mut Keystore);
    keystore.lock();
    1
}

pub const KEYSTORE_PAPER_BACKUP: i32 = 1;
pub const KEYSTORE_NO_PAPER_BACKUP: i32 = 2;

#[no_mangle]
pub unsafe extern "C" fn keystore_paper_backup(keystore: *mut raw::c_void) -> i32 {
    null_pointer_check!(keystore);
    let keystore = &mut *(keystore as *mut Keystore);
    let result = keystore.paper_backup();
    match error!(result) {
        true => KEYSTORE_PAPER_BACKUP,
        false => KEYSTORE_NO_PAPER_BACKUP,
    }
}

#[no_mangle]
pub unsafe extern "C" fn keystore_set_paper_backup(keystore: *mut raw::c_void) -> i32 {
    null_pointer_check!(keystore);
    let keystore = &mut *(keystore as *mut Keystore);
    let result = keystore.set_paper_backup();
    error!(result);
    1
}

#[no_mangle]
pub unsafe extern "C" fn keystore_phrase(
    keystore: *mut raw::c_void,
    password: *const raw::c_char,
) -> *const raw::c_char {
    null_pointer_check!(keystore);
    let keystore = &mut *(keystore as *mut Keystore);
    let password = cstr!(password, std::ptr::null());
    let result = keystore.phrase(password);
    let cstr = error!(result, std::ptr::null());
    let cstr = error!(CString::new(cstr), std::ptr::null());
    cstr.into_raw()
}

#[no_mangle]
pub unsafe extern "C" fn phrase_destroy(phrase: *mut raw::c_char) {
    CString::from_raw(phrase);
}

#[repr(C)]
struct Account {
    pub name: *const raw::c_char,
    pub ss58: *const raw::c_char,
    pub identicon_ptr: *const u8,
    pub identicon_len: i32,
    pub qrcode_ptr: *const u8,
    pub qrcode_len: i32,
}

#[no_mangle]
pub unsafe extern "C" fn keystore_account(keystore: *mut raw::c_void) -> *mut raw::c_void {
    null_pointer_check!(keystore, std::ptr::null_mut());
    let keystore = &mut *(keystore as *mut Keystore);
    let key = error!(keystore.get_key(Some(0)), std::ptr::null_mut());
    let name = error!(CString::new("/"), std::ptr::null_mut());
    let ss58 = error!(CString::new(key.ss58()), std::ptr::null_mut());
    let identicon = error!(key.identicon(), std::ptr::null_mut())
        .into_raw()
        .into_boxed_slice();
    let qrcode = error!(key.qrcode(), std::ptr::null_mut())
        .into_raw()
        .into_boxed_slice();
    let account = Box::new(Account {
        name: name.into_raw(),
        ss58: ss58.into_raw(),
        identicon_ptr: identicon.as_ptr(),
        identicon_len: identicon.len() as i32,
        qrcode_ptr: qrcode.as_ptr(),
        qrcode_len: qrcode.len() as i32,
    });
    std::mem::forget(identicon);
    std::mem::forget(qrcode);
    Box::into_raw(account) as *mut raw::c_void
}

#[no_mangle]
pub unsafe extern "C" fn account_destroy(account: *mut raw::c_void) {
    null_pointer_check!(account);
    let account = Box::from_raw(account as *mut Account);
    let _name = CString::from_raw(account.name as *mut raw::c_char);
    let _ss58 = CString::from_raw(account.ss58 as *mut raw::c_char);
    let _identicon = Box::from_raw(std::slice::from_raw_parts_mut(
        account.identicon_ptr as *mut u8,
        account.identicon_len as usize,
    ));
    let _qrcode = Box::from_raw(std::slice::from_raw_parts_mut(
        account.qrcode_ptr as *mut u8,
        account.qrcode_len as usize,
    ));
}
