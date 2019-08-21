import 'package:flutter/foundation.dart';
import 'package:flutter_firebase_template/core/models/user.dart';
import 'package:rxdart/rxdart.dart';

abstract class AuthenticationService {
  @protected
  final BehaviorSubject<User> userController;
  
  Stream<User> get userStream => userController.stream;
  String errorMessage;

  AuthenticationService() 
    : userController = BehaviorSubject<User>();

  Future<dynamic> getCurrentUser();
  Future<bool> loginWithEmailAndPassword(String email, String password);
  Future<dynamic> logout();
  Future<User> register(String email, String password);
}
