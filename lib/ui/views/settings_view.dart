import 'package:flutter/material.dart';
import 'package:flutter_firebase_template/core/viewmodels/settings_model.dart';
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
                    content: Text('Unsaved settings will be lost'),
                    actions: <Widget>[
                      FlatButton(
                        child: const Text('CANCEL'),
                        onPressed: () {
                          model.dismissAlert(false);
                        },
                      ),
                      FlatButton(
                        child: Text(
                          'DISCARD',
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
            title: Text('Settings'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  model.saveSettings();
                },
              ),
            ],
          ),
          body: ListView(
            children: <Widget>[
              SwitchListTile(
                value: model.useDarkTheme,
                title: Text('Use Dark Theme'),
                onChanged: model.switchToDarkTheme,
                secondary: const Icon(Icons.lightbulb_outline),
              ),
              Divider(),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text('App Language'),
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
