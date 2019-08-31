import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_firebase_template/core/models/user.dart';

abstract class AuthenticationService {
  @protected
  final StreamController<User> userController = StreamController<User>.broadcast();
  Stream<User> get userStream => userController.stream;
  String errorMessage;

  Future<User> getCurrentUser();
  Future<bool> loginWithEmailAndPassword(String email, String password);
  Future<dynamic> logout();
  Future<User> register(String email, String password);
}
