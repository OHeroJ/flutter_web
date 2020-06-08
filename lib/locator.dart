import 'package:flutter_web/services/net/web_repository.dart';
import 'package:get_it/get_it.dart';

import 'services/services.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => ServiceNavigation());
  locator.registerLazySingleton(() => WebRepository());
}
