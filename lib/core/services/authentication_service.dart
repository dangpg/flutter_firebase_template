import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_firebase_template/core/models/user.dart';

abstract class AuthenticationService {
  @protected
  final StreamController<User> userController;
  Stream<User> get userStream => userController.stream;
  String errorMessage;

  AuthenticationService() : userController = StreamController<User>.broadcast();

  Future<User> getCurrentUser();
  Future<bool> loginWithEmailAndPassword(String email, String password);
  Future<dynamic> logout();
  Future<User> register(String email, String password);
}
