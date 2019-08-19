import 'package:flutter_firebase_template/core/models/item.dart';

class HomeViewArgs {
  final String snackbarMessage;
  final Item deletedItem;

  HomeViewArgs({this.snackbarMessage, this.deletedItem});
}