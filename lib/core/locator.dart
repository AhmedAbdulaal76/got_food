import 'package:get_it/get_it.dart';
import 'package:got_food/common/providers/userViewModel.dart';
import 'package:got_food/common/services/category_service.dart';
import 'package:got_food/common/services/user_service.dart';
import 'package:got_food/features/account/profile-view/profileViewModel.dart';
import 'package:got_food/features/account/profile-view/profile_service.dart';
import 'package:got_food/features/auth/auth_service.dart';
import 'package:got_food/features/auth/login-view/login_viewModel.dart';
import 'package:got_food/features/auth/register-view/register_viewModel.dart';
import 'package:got_food/features/auth/reset-password-view/reset_viewModel.dart';
import 'package:got_food/features/favourites/favorites-view/favoritesViewModel.dart';
import 'package:got_food/features/favourites/favorites_service.dart';
import 'package:got_food/features/home/home_service.dart';
import 'package:got_food/features/recipes/recipe-details-view/recipeDetailsViewModel.dart';
import 'package:got_food/features/recipes/recipes_service.dart';
import 'package:got_food/features/search/search-view/searchViewModel.dart';
import 'package:got_food/features/search/search-view/search_history_repository.dart';
import 'package:got_food/features/search/search_service.dart';

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
  locator.registerLazySingleton(() => LoginViewModel(locator<AuthService>()));
  locator
      .registerLazySingleton(() => RegisterViewModel(locator<AuthService>()));
  locator.registerLazySingleton(() => ResetViewModel(locator<AuthService>()));
  locator.registerLazySingleton(() => RecipesService());
  locator.registerLazySingleton(
      () => RecipeDetailsViewModel(locator<RecipesService>()));
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => UserViewModel(locator<UserService>()));
  locator.registerLazySingleton(() => SearchService());
  locator.registerLazySingleton(() => SearchHistoryRepository());
  locator.registerLazySingleton(() => SearchViewModel(
      locator<SearchService>(), locator<SearchHistoryRepository>()));
  locator.registerLazySingleton(() => ProfileService());
  locator
      .registerLazySingleton(() => ProfileViewModel(locator<ProfileService>()));
  locator.registerLazySingleton(() => FavoritesService());
  locator.registerLazySingleton(
      () => FavoritesViewModel(locator<FavoritesService>()));
}
