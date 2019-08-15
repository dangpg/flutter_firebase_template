import 'package:flutter_firebase_template/core/models/user.dart';
import 'package:rxdart/rxdart.dart';

abstract class AuthenticationService {
  final BehaviorSubject<User> userController;
  String errorMessage;

  AuthenticationService() 
    : userController = BehaviorSubject<User>();

  Future<dynamic> getCurrentUser();

  Future<bool> loginWithEmailAndPassword(String email, String password);

  Future<dynamic> logout();
}
