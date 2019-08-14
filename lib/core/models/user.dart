import 'package:firebase_auth/firebase_auth.dart';

class User {
  String id;
  String email;

  User({this.id, this.email});

  User.initial() : id = '-1', email = '';

  User.fromFirebaseUser(FirebaseUser firebaseUser) {
    this.id = firebaseUser.uid;
    this.email = firebaseUser.email;
  }
}