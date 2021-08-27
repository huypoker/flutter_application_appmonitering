import 'package:flutter_application_appmonitering/services/authenications_services/auth_services.dart';
import 'package:get_it/get_it.dart';

import 'services/authenications_services/firestore_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthServices());
  locator.registerLazySingleton(() => FirestoreService());
}