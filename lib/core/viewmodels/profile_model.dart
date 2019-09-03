import 'dart:io';

import 'package:flutter_firebase_template/core/models/user.dart';
import 'package:flutter_firebase_template/core/models/user_data.dart';
import 'package:flutter_firebase_template/core/services/authentication_service.dart';
import 'package:flutter_firebase_template/core/services/database_service.dart';
import 'package:flutter_firebase_template/core/services/storage_service.dart';
import 'package:flutter_firebase_template/core/viewmodels/base_model.dart';
import 'package:flutter_firebase_template/locator.dart';
import 'package:flutter_firebase_template/ui/navigation_service.dart';
import 'package:flutter_firebase_template/ui/views/home_view_args.dart';
import 'package:image_picker/image_picker.dart';

class ProfileModel extends BaseModel {
  final AuthenticationService _authService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();
  final DatabaseService _dbService = locator<DatabaseService>();

  UserData _userData;
  UserData userData; // dirty object
  File imageFile;

  bool get pendingChanges => imageFile != null || _userData != userData;
  
  bool dismissAlert([bool result]) => _navigationService.pop(result);

  Future<void> getUserData() async {
    setState(ViewState.Busy);
    User user = await _authService.getCurrentUser();
    _userData = await _dbService.readUserData(user.id);
    userData = UserData.clone(_userData);
    setState(ViewState.Idle);
  }

  void updateDirtyUserData(String username, String firstname, String lastname) {
    userData
      ..username = username
      ..firstname = firstname
      ..lastname = lastname;
  }

  Future<void> saveProfile(String snackbarMessage) async {
    setState(ViewState.Busy);
    if (imageFile != null) {
      String url = await _storageService.uploadAvatarFileImage(_userData.id, imageFile);
      userData.avatarUrl = url;
    }
    await _dbService.updateUserData(userData);
    setState(ViewState.Idle);
    _navigationService.returnToHomeView(
      arguments: HomeViewArgs(snackbarMessage: snackbarMessage),
    );
  }

  Future<void> getImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(ViewState.Idle);
  }
}
