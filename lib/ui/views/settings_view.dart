import 'package:flutter/material.dart';
import 'package:flutter_firebase_template/core/viewmodels/settings_model.dart';
import 'package:flutter_firebase_template/ui/views/base_view.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<SettingsModel>(
      onModelReady: (model) {},
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
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
          ],
        ),
      ),
    );
  }
}
