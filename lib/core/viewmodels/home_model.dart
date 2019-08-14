import 'package:flutter_firebase_template/core/services/authentication_service.dart';
import 'package:flutter_firebase_template/core/viewmodels/base_model.dart';
import 'package:flutter_firebase_template/locator.dart';

class HomeModel extends BaseModel {
  final AuthenticationService _authService = locator<AuthenticationService>();

  void logout() async {
    setState(ViewState.Busy);
    await _authService.logout();
    setState(ViewState.Idle);
  } 
}
