import 'package:flutter_firebase_template/core/models/item.dart';
import 'package:flutter_firebase_template/core/models/user_data.dart';

abstract class DatabaseService {
  Future<UserData> readUserData(String uid);
  Future<List<Item>> readItems();
  Future<void> createItem(Item item);
  Future<Item> readItem(String itemId);
  Future<void> updateItem(Item item);
  Future<void> deleteItem(String itemId);
  Future<void> createUserData(UserData userData);
} 