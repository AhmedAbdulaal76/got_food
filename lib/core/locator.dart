import 'package:get_it/get_it.dart';
import 'package:got_food/common/services/category_service.dart';
import 'package:got_food/features/auth/auth_service.dart';
import 'package:got_food/features/home/home_service.dart';

import '../common/providers/CategoryViewModel.dart';
import '../features/home/home-view/homeViewModel.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => HomeService());
  locator.registerLazySingleton(() => HomeViewModel(locator<HomeService>()));
  locator.registerLazySingleton(() => CategoryService());
  locator.registerLazySingleton(
      () => CategoryViewModel(locator<CategoryService>()));
  locator.registerLazySingleton(() => AuthService());
}
