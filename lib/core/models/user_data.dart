import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String firstname;
  final String lastname;
  final String id;
  final String email;
  final String username;
  final DocumentReference reference;

  UserData.fromMap(Map<String, dynamic> map, {this.reference})
    : firstname = map['firstname'] ?? '',
      lastname = map['lastname'] ?? '',
      id = map['id'] ?? '',
      email = map['email'] ?? '',
      username = map['username'] ?? '';


  UserData.fromSnapshot(DocumentSnapshot snapshot) 
    : this.fromMap(snapshot.data, reference: snapshot.reference);
}