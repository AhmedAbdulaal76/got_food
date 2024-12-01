import 'package:flutter/material.dart';
import 'package:got_food/common/models/recipe.dart';
import 'package:got_food/common/services/category_service.dart';
import 'package:got_food/common/services/profile_service.dart';
import '../../recipes/recipes_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final ProfileService _profileService;

  ProfileViewModel(this._profileService);

  List<Recipe> recipes = [];

  Map<String, List<Recipe>> fetchedMap = {};

  void fetchRecipesByUserId(String userId) {
    // check if the category has been fetched before
    if (fetchedMap.containsKey(userId.toString())) {
      fetchedMap[userId]!;
    } else {
      updateUserRecipes(userId); // otherwise fetch the category
    }
  }
  Future<void> updateUserRecipes(String userId) async {
    try {
      List<Map<String, dynamic>> response =
      await _profileService.fetchRecipesByUserId(userId);
      recipes = response.map((e) => Recipe.fromJson(e)).toList();
      fetchedMap.addAll({userId: recipes});
      print(
          '[Profile View Model] Recipes by userId: ${fetchedMap[userId]}');
    } catch (e) {
      print('[Profile View Model] Error fetching recipes by userId: $e');
    } finally {
      notifyListeners();
    }
  }
}
