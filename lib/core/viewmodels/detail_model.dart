import 'package:flutter_firebase_template/core/models/item.dart';
import 'package:flutter_firebase_template/core/services/database_service.dart';
import 'package:flutter_firebase_template/core/viewmodels/base_model.dart';
import 'package:flutter_firebase_template/locator.dart';
import 'package:flutter_firebase_template/ui/navigation_service.dart';

class DetailModel extends BaseModel {
  final DatabaseService _dbService = locator<DatabaseService>();
  final NavigationService _navigationService = locator<NavigationService>();
  Item item;

  Future deleteItem() async {
    dismissAlert();
    setState(ViewState.Busy);
    await _dbService.deleteItem(item.id);
    setState(ViewState.Idle);
    _navigationService.returnToHomeView();
  }

  dismissAlert() => _navigationService.pop();
}