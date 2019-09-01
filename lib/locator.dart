import 'package:flutter_firebase_template/core/services/authentication_service.dart';
import 'package:flutter_firebase_template/core/services/authentication_service_impl.dart';
import 'package:flutter_firebase_template/core/services/database_service.dart';
import 'package:flutter_firebase_template/core/services/database_service_impl.dart';
import 'package:flutter_firebase_template/core/services/local_storage_service.dart';
import 'package:flutter_firebase_template/core/services/settings_service.dart';
import 'package:flutter_firebase_template/core/services/storage_service.dart';
import 'package:flutter_firebase_template/core/services/storage_service_impl.dart';
import 'package:flutter_firebase_template/core/viewmodels/detail_model.dart';
import 'package:flutter_firebase_template/core/viewmodels/home_model.dart';
import 'package:flutter_firebase_template/core/viewmodels/login_model.dart';
import 'package:flutter_firebase_template/core/viewmodels/profile_model.dart';
import 'package:flutter_firebase_template/core/viewmodels/register_model.dart';
import 'package:flutter_firebase_template/core/viewmodels/settings_model.dart';
import 'package:flutter_firebase_template/ui/navigation_service.dart';
import 'package:flutter_firebase_template/ui/theme_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();

setupLocator() {
  locator.registerLazySingleton<AuthenticationService>(
      () => (AuthenticationServiceImpl()));
  locator.registerLazySingleton(
      () => NavigationService(locator<AuthenticationService>().userStream));
  locator.registerLazySingleton<DatabaseService>(() => DatabaseServiceImpl());
  locator.registerLazySingleton<StorageService>(() => StorageServiceImpl());
  locator.registerLazySingleton(() => LocalStorageService());

  locator.registerLazySingleton(() => SettingsService());
  locator.registerLazySingleton(() => ThemeService());

  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => DetailModel());
  locator.registerFactory(() => RegisterModel());
  locator.registerFactory(() => SettingsModel());
  locator.registerFactory(() => ProfileModel());
}
