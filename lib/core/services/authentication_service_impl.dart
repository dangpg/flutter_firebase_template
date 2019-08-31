import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_template/core/models/user.dart';
import 'package:flutter_firebase_template/core/services/authentication_service.dart';

class AuthenticationServiceImpl extends AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthenticationServiceImpl() {
    _auth.onAuthStateChanged.map(_userMapper).pipe(userController.sink);
  }

  User _userMapper (FirebaseUser firebaseUser) => firebaseUser == null ? null : User.fromFirebaseUser(firebaseUser);

  @override
  Future<User> getCurrentUser() async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    return firebaseUser == null ? null : User.fromFirebaseUser(firebaseUser);
  }

  @override
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL': {
          errorMessage = e.message;
          return false;
        }
        case 'ERROR_USER_NOT_FOUND':{
          errorMessage = e.message;
          return false;
        }
        case 'ERROR_WRONG_PASSWORD':{
          errorMessage = e.message;
          return false;
        }
        default:{
          errorMessage = e.message;
          return false;
        }
      }
    }
  }

  @override
  Future<dynamic> logout() async {
    await _auth.signOut();
  }

  @override
  Future<User> register(String email, String password) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return User.fromFirebaseUser(authResult.user);
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'ERROR_WEAK_PASSWORD': {
          errorMessage = e.message;
          return null;
        }
        case 'ERROR_INVALID_EMAIL': {
          errorMessage = e.message;
          return null;
        }
        case 'ERROR_EMAIL_ALREADY_IN_USE': {
          errorMessage = e.message;
          return null;
        }
        default:{
          errorMessage = e.message;
          return null;
        }
      }
    }
  }
}
