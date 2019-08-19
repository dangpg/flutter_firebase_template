import 'dart:async';

import 'package:flutter_firebase_template/core/models/item.dart';
import 'package:flutter_firebase_template/core/models/user_data.dart';
import 'package:flutter_firebase_template/core/services/authentication_service.dart';
import 'package:flutter_firebase_template/core/services/database_service.dart';
import 'package:flutter_firebase_template/core/viewmodels/base_model.dart';
import 'package:flutter_firebase_template/locator.dart';
import 'package:flutter_firebase_template/ui/navigation_service.dart';
import 'package:flutter_firebase_template/ui/router.dart';
import 'package:flutter_firebase_template/ui/views/detail_view_args.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class HomeModel extends BaseModel {
  final AuthenticationService _authService = locator<AuthenticationService>();
  final DatabaseService _dbService = locator<DatabaseService>();
  final NavigationService _navigationService = locator<NavigationService>();

  UserData userData;
  List<Item> items = List<Item>();

  void openDetailView(Item item) {
    _navigationService.navigateTo(
      Router.detail,
      arguments: DetailViewArgs(item: item),
    );
  }

  Future createRandomItem() async {
    setState(ViewState.Busy);
    String randomTitle = lorem(words: 1).replaceAll('.', '');
    String randomBody = lorem();
    await _dbService.createItem(Item(title: randomTitle, body: randomBody));
    setState(ViewState.Idle);
  }

  Future<void> getItems() async {
    setState(ViewState.Busy);
    items = await _dbService.readItems();
    setState(ViewState.Idle);
  }

  Future getUserData(String uid) async {
    if (uid != "-1") {
      setState(ViewState.Busy);
      userData = await _dbService.readUserData(uid);
      setState(ViewState.Idle);
    }
  }

  Future logout() async {
    setState(ViewState.Busy);
    await _authService.logout();
    setState(ViewState.Idle);
  }

  Future undoDeleteItem(Item deletedItem) async {
    setState(ViewState.Busy);
    await _dbService.createItem(deletedItem);
    setState(ViewState.Idle);
    getItems();
  }
}
