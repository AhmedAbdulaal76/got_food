import 'package:got_food/common/providers/bottomNavigationProvider.dart';
import 'package:got_food/common/providers/userViewModel.dart';
import 'package:got_food/core/locator.dart';
import 'package:got_food/features/auth/login-view/login_viewModel.dart';
import 'package:got_food/features/auth/register-view/register_viewModel.dart';
import 'package:got_food/features/home/home-view/homeViewModel.dart';
import 'package:got_food/features/recipes/recipe-details-view/recipeDetailsViewModel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../common/providers/CategoryViewModel.dart';
import '../features/account/profile-view/profileViewModel.dart';

List<SingleChildWidget> get appProviders => [
      ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
      ChangeNotifierProvider(create: (_) => locator<HomeViewModel>()),
      ChangeNotifierProvider(create: (_) => locator<CategoryViewModel>()),
      ChangeNotifierProvider(create: (_) => locator<LoginViewModel>()),
      ChangeNotifierProvider(create: (_) => locator<RegisterViewModel>()),
      ChangeNotifierProvider(create: (_) => locator<RecipeDetailsViewModel>()),
      ChangeNotifierProvider(create: (_) => locator<UserViewModel>()),
      ChangeNotifierProvider(create: (_) => locator<ProfileViewModel>()),
    ];
