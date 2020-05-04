import 'dart:async';
import 'package:flutter/material.dart';

class AppLocalizations {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(
      context,
      AppLocalizations,
    );
  }

  String get appTitle => 'Flutter Keystore';

  String get unlockFormPasswordLabel => 'Password';
  String get unlockFormValidationError => 'Wrong password';
  String get unlockFormUnlockButton => 'Unlock account';

  String get lockButtonTooltip => 'Lock account';
  String get secretFormFieldLabel => 'Secret phrase';

  String get newPasswordFormFieldNewPasswordLabel =>'New password (min 8 chars)';
  String get newPasswordFormFieldConfirmPasswordLabel => 'Confirm password';
  String get newPasswordFormFieldLengthError => 'Password needs to be at least eight chars';
  String get newPasswordFormFieldMissmatchError => 'Passwords don\'t match';

  String get createAccountFormImportButton => 'Import with seed phrase';
  String get createAccountFormCreateButton => 'Create account';

  String get paperBackupFormSecretMissmatchError => 'Secret phrase doesn\'t match.';
  String get paperBackupFormConfirmButton => 'Confirm';

  String get welcomeTitle => 'Welcome to Sunshine';
  String get welcomeMessage =>
    'Sunshine is a secure DAO for Substrate.\n' +
    'It allows you to hold dots & tokens, and serves as ' +
    'your bridge to decentralized applications.';
  String get welcomeContinueButton => 'Continue';

  String get createPasswordTitle => 'Create Password';

  String get accountImageTitle => 'Your unique account image';
  String get accountImageMessage1 =>
    'This image, was programmatically generated for you using your account number.';
  String get accountImageMessage2 =>
    'You\'ll see this image every time you need to confirm a transaction.';
  String get accountImageNextButton => 'Next';

  String get termsOfUseTitle => 'Terms of use';
  String get termsOfUseAcceptButton => 'Accept';

  String get secretBackupTitle => 'Secret Backup Phrase';
  String get secretBackupDescription =>
    'Your secret backup phrase makes it easy to back up and restore your account.';
  String get secretBackupDisclaimer =>
    'Never disclose your backup phrase. Anyone with this phrase can take ' +
    'your dots forever.';
  String get secretBackupTips =>
    'Tips:\n\n' +
    'Store this phrase in a password manager like 1password.\n\n' +
    'Write this phrase on a piece of paper and store it in a secure location. If you ' +
    'want even more security, write it down on multiple pieces of paper and store ' +
    'each in two to three different locations.\n\n' +
    'Memorize this phrase.';
  String get secretBackupNextButton => 'Next';
  String get secretBackupRemindButton => 'Remind me later';

  String get secretConfirmTitle => 'Confirm Secret Phrase';
  String get secretConfirmMessage => 'Please select each word in order to ensure it\'s correct.';

  String get restoreAccountTitle => 'Restore your Account with Seed Phrase';
  String get restoreAccountMessage =>
    'Enter your secret twelve word phrase here to restore your vault.';
  String get restoreAccountRestoreButton => 'Restore';

  String get loginTitle => 'Welcome Back!';
  String get loginMessage => 'The decentralized web awaits';

  String get accountDetailsTitle => 'Account Details';
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  Future<AppLocalizations> load(Locale locale) {
    return Future(() => AppLocalizations());
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) {
    return false;
  }

  @override
  bool isSupported(Locale locale) {
    return locale.languageCode.toLowerCase().contains('en');
  }
}
