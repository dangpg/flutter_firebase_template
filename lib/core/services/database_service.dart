import 'package:flutter_firebase_template/core/models/item.dart';
import 'package:flutter_firebase_template/core/models/user_data.dart';

abstract class DatabaseService {
  Future<void> createUserData(UserData userData);
  Future<UserData> readUserData(String uid);
  Future<void> updateUserData(UserData userData);
  Future<List<Item>> readItems();
  Future<void> createItem(Item item);
  Future<Item> readItem(String itemId);
  Future<void> updateItem(Item item);
  Future<void> deleteItem(String itemId);
} 