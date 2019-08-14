import 'package:flutter_firebase_template/core/models/user_data.dart';
import 'package:flutter_firebase_template/core/services/authentication_service.dart';
import 'package:flutter_firebase_template/core/services/database_service.dart';
import 'package:flutter_firebase_template/core/viewmodels/base_model.dart';
import 'package:flutter_firebase_template/locator.dart';

class HomeModel extends BaseModel {
  final AuthenticationService _authService = locator<AuthenticationService>();
  final DatabaseService _dbService = locator<DatabaseService>();

  UserData userData;

  Future getUserData(String uid) async {
    if (uid != "-1") {
      setState(ViewState.Busy);
      userData = UserData.fromSnapshot(await _dbService.getUserDataById(uid));
      setState(ViewState.Idle);
    }
  }

  Future logout() async {
    setState(ViewState.Busy);
    await _authService.logout();
    setState(ViewState.Idle);
  }
}
