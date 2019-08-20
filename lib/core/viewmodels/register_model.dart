import 'package:flutter_firebase_template/core/services/authentication_service.dart';
import 'package:flutter_firebase_template/core/viewmodels/base_model.dart';
import 'package:flutter_firebase_template/locator.dart';
import 'package:flutter_firebase_template/ui/navigation_service.dart';
import 'package:rxdart/rxdart.dart';

typedef ValidatorSignature = String Function(String value);

class RegisterModel extends BaseModel {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final PublishSubject _errorStream = PublishSubject<String>();
  Observable<String> get errorStream => _errorStream.stream;

  @override
  void dispose() {
    _errorStream.close();
    super.dispose();
  }

  Future register(String email, String password) async {
    setState(ViewState.Busy);
    bool result = await _authenticationService.register(email, password);
    if (result) {
      // TODO: login user and navigate to home view
    } else {
      // TODO: display error message
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
