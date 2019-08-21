import 'package:flutter_firebase_template/core/viewmodels/base_model.dart';

class SettingsModel extends BaseModel {
  bool _useDarkTheme;
  bool get useDarkTheme => _useDarkTheme;

  SettingsModel() 
      : _useDarkTheme = false;

  void switchToDarkTheme(bool value) {
    setState(ViewState.Busy);
    _useDarkTheme = value;
    setState(ViewState.Idle);
  }
}
