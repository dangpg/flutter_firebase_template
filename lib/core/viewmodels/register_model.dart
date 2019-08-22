import 'dart:async';

import 'package:flutter_firebase_template/core/models/user.dart';
import 'package:flutter_firebase_template/core/models/user_data.dart';
import 'package:flutter_firebase_template/core/services/authentication_service.dart';
import 'package:flutter_firebase_template/core/services/database_service.dart';
import 'package:flutter_firebase_template/core/viewmodels/base_model.dart';
import 'package:flutter_firebase_template/locator.dart';
import 'package:flutter_firebase_template/ui/navigation_service.dart';

typedef ValidatorSignature = String Function(String value);

class RegisterModel extends BaseModel {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final StreamController _errorStream = StreamController<String>();
  Stream<String> get errorStream => _errorStream.stream;

  @override
  void dispose() {
    _errorStream.close();
    super.dispose();
  }

  Future<void> register(String email, String password) async {
    setState(ViewState.Busy);
    User user = await _authenticationService.register(email, password);
    if (user != null) {
      await _databaseService.createUserData(UserData.fromUser(user));
      _navigationService.navigateTo(Router.home);
    } else {
      _errorStream.addError(_authenticationService.errorMessage);
    }
    setState(ViewState.Idle);
  }

  String emailValidator(String email) {
    if (!email.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String confirmPasswordValidator(String password, String confirmPassword) {
    if (password != confirmPassword) {
      return 'Please make sure your passwords match';
    }
    return null;
  }
}
