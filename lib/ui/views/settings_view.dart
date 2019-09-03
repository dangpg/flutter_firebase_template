import 'package:flutter/material.dart';
import 'package:flutter_firebase_template/core/viewmodels/settings_model.dart';
import 'package:flutter_firebase_template/ui/app_localizations.dart';
import 'package:flutter_firebase_template/ui/views/base_view.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<SettingsModel>(
      onModelReady: (model) {},
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          if (!model.pendingChanges) return Future.value(true);

          return await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text(AppLocalizations.of(context).showdialogUnsavedChangesWarning),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(AppLocalizations.of(context).showdialogCancel),
                        onPressed: () {
                          model.dismissAlert(false);
                        },
                      ),
                      FlatButton(
                        child: Text(
                          AppLocalizations.of(context).showdialogDiscard,
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          model.revertChanges();
                          model.dismissAlert(true);
                        },
                      )
                    ],
                  );
                },
              ) ??
              false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).settingsAppbarTitle),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  model.saveSettings(AppLocalizations.of(context).settingsSettingUpdated);
                },
              ),
            ],
          ),
          body: ListView(
            children: <Widget>[
              SwitchListTile(
                value: model.useDarkTheme,
                title: Text(AppLocalizations.of(context).settingsListTileThemeTitle),
                onChanged: model.switchToDarkTheme,
                secondary: const Icon(Icons.lightbulb_outline),
              ),
              Divider(),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(AppLocalizations.of(context).settingsListTileLanguageTitle),
                trailing: DropdownButton<String>(
                  value: model.selectedLanguage,
                  onChanged: (String newValue) {
                    model.switchAppLanguage(newValue);
                  },
                  items: model.supportedLanguage
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
