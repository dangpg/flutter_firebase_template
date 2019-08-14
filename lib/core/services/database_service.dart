import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Firestore _db = Firestore.instance;
  final String userCollection = 'users';

  Future<DocumentSnapshot> getUserDataById(String uid) {
    print('uid:' + uid);
    return _db.collection(userCollection).document(uid).get();
  }
}