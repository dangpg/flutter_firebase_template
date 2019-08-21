import 'package:flutter_firebase_template/core/services/authentication_service.dart';
import 'package:flutter_firebase_template/core/services/authentication_service_impl.dart';
import 'package:flutter_firebase_template/core/services/database_service.dart';
import 'package:flutter_firebase_template/core/services/database_service_impl.dart';
import 'package:flutter_firebase_template/core/viewmodels/detail_model.dart';
import 'package:flutter_firebase_template/core/viewmodels/home_model.dart';
import 'package:flutter_firebase_template/core/viewmodels/login_model.dart';
import 'package:flutter_firebase_template/core/viewmodels/register_model.dart';
import 'package:flutter_firebase_template/core/viewmodels/settings_model.dart';
import 'package:flutter_firebase_template/ui/navigation_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton<AuthenticationService>(
      () => (AuthenticationServiceImpl()));
  locator.registerLazySingleton(() => NavigationService(
      locator<AuthenticationService>().userController.stream));
  locator.registerLazySingleton<DatabaseService>(() => DatabaseServiceImpl());

  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => DetailModel());
  locator.registerFactory(() => RegisterModel());
  locator.registerFactory(() => SettingsModel());
}
