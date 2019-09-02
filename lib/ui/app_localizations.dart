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
