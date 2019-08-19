import 'dart:async';

import 'package:flutter_firebase_template/core/models/item.dart';
import 'package:flutter_firebase_template/core/services/database_service.dart';
import 'package:flutter_firebase_template/core/viewmodels/base_model.dart';
import 'package:flutter_firebase_template/locator.dart';
import 'package:flutter_firebase_template/ui/navigation_service.dart';
import 'package:flutter_firebase_template/ui/views/home_view_args.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class DetailModel extends BaseModel {
  final DatabaseService _dbService = locator<DatabaseService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final StreamController<String> snackbarController =
      StreamController<String>();
  Item item;

  Future deleteItem() async {
    dismissAlert();
    setState(ViewState.Busy);
    await _dbService.deleteItem(item.id);
    setState(ViewState.Idle);
    _navigationService.returnToHomeView(
      arguments:
          HomeViewArgs(snackbarMessage: 'Item deleted', deletedItem: item),
    );
  }

  dismissAlert() => _navigationService.pop();

  void randomizeItem() {
    setState(ViewState.Busy);
    String randomTitle = lorem(words: 1).replaceAll('.', '');
    String randomBody = lorem();
    item.title = randomTitle;
    item.body = randomBody;
    setState(ViewState.Idle);
  }

  void updateItem() async {
    setState(ViewState.Busy);
    await _dbService.updateItem(item);
    setState(ViewState.Idle);
    snackbarController.add('Item updated');
  }

  void dispose() {
    snackbarController.close();
    super.dispose();
  }
}
