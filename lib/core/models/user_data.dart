import 'package:flutter_firebase_template/core/models/user.dart';

class UserData {
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String username;

  UserData.fromUser(User user) 
      : id = user.id, 
        email = user.email,
        firstname = '',
        lastname = '',
        username = '';

  UserData.fromMap(Map<String, dynamic> map, String id)
      : id = id,
        firstname = (map ?? const {})['firstname'] ?? '',
        lastname = (map ?? const {})['lastname'] ?? '',
        email = (map ?? const {})['email'] ?? '',
        username = (map ?? const {})['username'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'username': username
    };
  }
}
