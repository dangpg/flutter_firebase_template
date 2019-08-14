import 'package:flutter_firebase_template/core/services/authentication_service.dart';
import 'package:flutter_firebase_template/core/viewmodels/home_model.dart';
import 'package:flutter_firebase_template/core/viewmodels/login_model.dart';
import 'package:flutter_firebase_template/ui/navigation_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => NavigationService(
      locator<AuthenticationService>().userController.stream));

  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => LoginModel());
}