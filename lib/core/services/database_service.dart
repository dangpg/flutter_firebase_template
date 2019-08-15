import 'package:flutter_firebase_template/core/models/item.dart';
import 'package:flutter_firebase_template/core/models/user_data.dart';

abstract class DatabaseService {
  Future<UserData> readUserData(String uid);
  Future<List<Item>> readItems();
  Future createItem(Item item);
  Future<Item> readItem(String itemId);
  Future updateItem(Item item);
  Future deleteItem(String itemId);
} 