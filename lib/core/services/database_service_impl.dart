import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_template/core/models/item.dart';
import 'package:flutter_firebase_template/core/models/user_data.dart';
import 'package:flutter_firebase_template/core/services/database_service.dart';

class DatabaseServiceImpl extends DatabaseService {
  Firestore _db = Firestore.instance;
  final String userCollection = 'users';
  final String itemCollection = 'items';

  @override
  Future<void> createUserData(UserData userData) async {
    await _db
        .collection(userCollection)
        .document(userData.id)
        .setData(userData.toJson());
  }

  @override
  Future<UserData> readUserData(String uid) async {
    DocumentSnapshot doc =
        await _db.collection(userCollection).document(uid).get();
    return UserData.fromJson(doc.data, doc.documentID);
  }

  @override
  Future<void> updateUserData(UserData userData) async {
    return _db
        .collection(userCollection)
        .document(userData.id)
        .updateData(userData.toJson());
  }

  @override
  Future<void> createItem(Item item) async {
    await _db.collection(itemCollection).add(item.toJson());
  }

  @override
  Future<Item> readItem(String itemId) async {
    DocumentSnapshot doc =
        await _db.collection(userCollection).document(itemId).get();
    return Item.fromMap(doc.data, doc.documentID);
  }

  @override
  Future<void> updateItem(Item item) {
    return _db
        .collection(itemCollection)
        .document(item.id)
        .updateData(item.toJson());
  }

  @override
  Future<void> deleteItem(String itemId) {
    return _db.collection(itemCollection).document(itemId).delete();
  }

  @override
  Future<List<Item>> readItems() async {
    QuerySnapshot snapshot =
        await _db.collection(itemCollection).getDocuments();
    return snapshot.documents
        .map((doc) => Item.fromMap(doc.data, doc.documentID))
        .toList();
  }
}
