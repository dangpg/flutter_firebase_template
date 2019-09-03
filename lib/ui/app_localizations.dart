import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_template/i18n/messages_all.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get title => Intl.message('Flutter Firebase Template',
      name: 'title', desc: 'The application title');

  String get detailItemDeleted => Intl.message('Item deleted',
      name: 'detailItemDeleted',
      desc: 'Snackbar message when item gets deleted');

  String get detailItemUpdated => Intl.message('Item updated',
      name: 'detailItemUpdated',
      desc: 'Snackbar message when item gets updated');

  String get formEmailValidator => Intl.message('Please enter a valid email',
      name: 'formEmailValidator',
      desc: 'Error message when email validation fails');

  String get formNonEmptyValidator => Intl.message('Cannot be empty',
      name: 'formNonEmptyValidator', desc: 'Error message when field is empty');

  String get profileProfileUpdated => Intl.message('Profile updated',
      name: 'profileProfileUpdated',
      desc: 'Snackbar message when profile gets updated');

  String get formConfirmPasswordValidator =>
      Intl.message('Please make sure your passwords match',
          name: 'formConfirmPasswordValidator',
          desc: 'Error message when confirm password validation fails');

  String get settingsSettingUpdated => Intl.message('Settings saved',
      name: 'settingsSettingUpdated',
      desc: 'Snackbar message when settings gets saved');

  String get showdialogUnsavedChangesWarning =>
      Intl.message('Unsaved changes will be lost',
          name: 'showdialogUnsavedChangesWarning',
          desc: 'Warning message when leaving without saving');

  String get showdialogCancel =>
      Intl.message('Cancel', name: 'showdialogCancel', desc: 'Cancel');

  String get showdialogDiscard =>
      Intl.message('Discard', name: 'showdialogDiscard', desc: 'Discard');

  String get detailDialogDeleteItemTitle => Intl.message('Delete Item',
      name: 'detailDialogDeleteItemTitle',
      desc: 'Title of showDialog when deleting item');

  String get detailDialogDeleteItemAction => Intl.message('Delete',
      name: 'detailDialogDeleteItemAction',
      desc: 'Action text of showDialog when deleting item');

  String get snackbarActionUndo => Intl.message('Undo',
      name: 'snackbarActionUndo', desc: 'Action text of undo');

  String get homeAppbarTitle => Intl.message('Home',
      name: 'homeAppbarTitle', desc: 'Appbar title of homeview');

  String get homeDrawerItem1Title => Intl.message('Item 1',
      name: 'homeDrawerItem1Title', desc: 'Title of dummy list tile item');

  String get homeDrawerSettingsTitle => Intl.message('Settings',
      name: 'homeDrawerSettingsTitle',
      desc: 'Title of settings list tile item');

  String get homeDrawerLogoutTitle => Intl.message('Logout',
      name: 'homeDrawerLogoutTitle', desc: 'Title of logout list tile item');

  String get formEmailHintText => Intl.message('Email',
      name: 'formEmailHintText', desc: 'Form hint text for email field');

  String get formPasswordHintText => Intl.message('Password',
      name: 'formPasswordHintText', desc: 'Form hint text for password field');

  String get loginLoginButton => Intl.message('Login',
      name: 'loginLoginButton', desc: 'Button text for login button');

  String get loginRegisterLink => Intl.message('Click to register',
      name: 'loginRegisterLink', desc: 'Link text for register form');

  String get profileAppbarTitle => Intl.message('Profile',
      name: 'profileAppbarTitle', desc: 'Appbar title of profile view');

  String get formUsernameHintText => Intl.message('Username',
      name: 'formUsernameHintText', desc: 'Form hint text for username field');
      
  String get formUsernameLabelText => Intl.message('Username (optional)',
      name: 'formUsernameLabelText', desc: 'Form label text for username field');
      
  String get formFirstnameHintText => Intl.message('First name',
      name: 'formFirstnameHintText', desc: 'Form hint text for first name field');

  String get formFirstnameLabelText => Intl.message('First name (optional)',
      name: 'formFirstnameLabelText', desc: 'Form label text for first name field');
      
  String get formLastnameHintText => Intl.message('Last name',
      name: 'formLastnameHintText', desc: 'Form hint text for last name field');
      
  String get formLastnameLabelText => Intl.message('Last name (optional)',
      name: 'formLastnameLabelText', desc: 'Form label text for last name field');

  String get formConfirmPasswordHintText => Intl.message('Confirm Password',
      name: 'formConfirmPasswordHintText', desc: 'Form hint text for confirm password field');
      
  String get registerRegisterButton => Intl.message('Register',
      name: 'registerRegisterButton', desc: 'Button text for register button');

  String get settingsAppbarTitle => Intl.message('Settings',
      name: 'settingsAppbarTitle', desc: 'Appbar title of settings view');
      
  String get settingsListTileThemeTitle => Intl.message('Use Dark Theme',
      name: 'settingsListTileThemeTitle', desc: 'Title of list tile for changing theme');

  String get settingsListTileLanguageTitle => Intl.message('App Language',
      name: 'settingsListTileLanguageTitle', desc: 'Title of list tile for changing language');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'de'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
