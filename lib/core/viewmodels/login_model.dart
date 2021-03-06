import 'dart:async';

import 'package:flutter_firebase_template/core/services/authentication_service.dart';
import 'package:flutter_firebase_template/core/viewmodels/base_model.dart';
import 'package:flutter_firebase_template/locator.dart';
import 'package:flutter_firebase_template/ui/navigation_service.dart';
import 'package:flutter_firebase_template/ui/router.dart';

class LoginModel extends BaseModel {
  final AuthenticationService _authService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final StreamController _errorStream = StreamController<String>();
  Stream<String> get errorStream => _errorStream.stream;

  @override
  void dispose() {
    _errorStream.close();
    super.dispose();
  }

  Future<void> login(String email, String password) async {
    setState(ViewState.Busy);
    _errorStream.add('');
    bool result = await _authService.loginWithEmailAndPassword(email, password);

    if (result) {
      _navigationService.pushReplacementNamed(Router.home);
    } else {
      _errorStream.addError(_authService.errorMessage);
    }

    setState(ViewState.Idle);
  }

  void navigateToRegisterView() {
    _navigationService.navigateTo(Router.register);
  }
}
