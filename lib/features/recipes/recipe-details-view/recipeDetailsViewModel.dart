import 'package:flutter/material.dart';
import 'package:got_food/common/models/ingredient.dart';
import 'package:got_food/features/recipes/recipes_service.dart';

class RecipeDetailsViewModel extends ChangeNotifier {
  final RecipesService _recipesService;

  RecipeDetailsViewModel(this._recipesService);

  late BuildContext ctx;
  set context(BuildContext context) => ctx = context;

  bool isLoading = true;
  List<Ingredient> ingredients = [];
  Map<String, List<Ingredient>> fetchedMap = {};

  Future<void> fetchRecipeIngredients(String recipeId) async {
    // check if the category has been fetched before
    if (fetchedMap.containsKey(recipeId)) {
      fetchedMap[recipeId]!;
    } else {
      _fetchRecipeIngredients(recipeId); // otherwise fetch the category
    }
  }

  // fetch recipe ingredients
  Future<void> _fetchRecipeIngredients(String recipeId) async {
    isLoading = true;
    try {
      final List<Map<String, dynamic>> res =
          await _recipesService.fetchRecipeIngredients(recipeId);
      ingredients = res
          .map((e) => Ingredient.fromJson(e['ingredients']!,
              unit: e['unit'], quantity: (e['quantity'] as num).toDouble()))
          .toList();
      print(
          '[Recipe Details View Model] Ingredients: ${ingredients.map((e) => e.name)}');
      fetchedMap.addAll({recipeId: ingredients});
    } catch (e) {
      print(
          '[Recipe Details View Model] Error fetching recipe ingredients: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
