import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_template/core/models/user.dart';
import 'package:flutter_firebase_template/core/services/authentication_service.dart';

class AuthenticationServiceImpl extends AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthenticationServiceImpl() {
    _auth.onAuthStateChanged.listen(_userChanged);
  }

  void _userChanged(FirebaseUser firebaseUser) {
    if (firebaseUser == null) {
      userController.add(User.initial());
    } else {
      User user = User.fromFirebaseUser(firebaseUser);
      userController.add(user);
    }
  }

  Future<dynamic> getCurrentUser() async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    User user = User.fromFirebaseUser(firebaseUser);
    userController.add(user);
    return firebaseUser;
  }

  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on PlatformException catch (e) {
      // TODO: Customize error messages
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          errorMessage = e.message;
          return false;
        case 'ERROR_USER_NOT_FOUND':
          errorMessage = e.message;
          return false;
        case 'ERROR_WRONG_PASSWORD':
          errorMessage = e.message;
          return false;
        default:
          errorMessage = e.message;
          return false;
      }
    }
  }

  Future<dynamic> logout() async {
    await _auth.signOut();
  }
}
