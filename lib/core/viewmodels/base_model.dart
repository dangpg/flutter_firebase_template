import 'package:flutter/material.dart';
import 'package:flutter_firebase_template/core/viewmodels/viewstate.dart';
export 'package:flutter_firebase_template/core/viewmodels/viewstate.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}