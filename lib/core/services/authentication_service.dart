import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_template/core/models/user.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final BehaviorSubject<User> userController = BehaviorSubject<User>();
  String errorMessage;

  AuthenticationService() {
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

  Future<dynamic> getUser() async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    User user = User.fromFirebaseUser(firebaseUser);
    userController.add(user);
    return firebaseUser;
  }

  Future<bool> login(String email, String password) async {
    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
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

  Future<void> logout() async {
    await _auth.signOut();
  }
}
