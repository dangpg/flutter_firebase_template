import 'package:flutter_firebase_template/core/models/user.dart';

class UserData {
  final String id;
  String firstname;
  String lastname;
  String email;
  String username;
  String avatarUrl;

  UserData.fromUser(User user) 
      : id = user.id, 
        email = user.email,
        firstname = '',
        lastname = '',
        username = '',
        avatarUrl = '';

  UserData.fromJson(Map<String, dynamic> map, String id)
      : id = id,
        firstname = (map ?? const {})['firstname'] ?? '',
        lastname = (map ?? const {})['lastname'] ?? '',
        email = (map ?? const {})['email'] ?? '',
        username = (map ?? const {})['username'] ?? '',
        avatarUrl = (map ?? const {})['avatarUrl'] ?? '';

  UserData.clone(UserData userData)
      : id = userData.id,
        firstname = userData.firstname,
        lastname = userData.lastname,
        email = userData.email,
        username = userData.username,
        avatarUrl = userData.avatarUrl;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'username': username,
      'avatarUrl': avatarUrl
    };
  }

  bool operator ==(o) => o is UserData 
    && id == o.id
    && email == o.email
    && firstname == o.firstname
    && lastname == o.lastname
    && username == o.username
    && avatarUrl == o.avatarUrl;

  int get hashCode => id.hashCode ^ email.hashCode;
}
