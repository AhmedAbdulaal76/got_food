import 'package:get_it/get_it.dart';
import 'package:got_food/features/home/home_service.dart';

import '../features/home/home-view/homeViewModel.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => HomeService());
  locator.registerLazySingleton(() => HomeViewModel(locator<HomeService>()));
}
