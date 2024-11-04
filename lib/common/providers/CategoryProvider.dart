import 'package:flutter/material.dart';
import 'package:got_food/common/models/recipe.dart';
import 'package:got_food/common/services/category_service.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryService _categoryService;

  CategoryViewModel(this._categoryService);

  List<Recipe> recipes = [];
  bool isRecipesLoading = true;

  Map<String, List<Recipe>> fetchedMap = {};

  void fetchRecipesByCategory(String categoryId) {
    // check if the category has been fetched before
    if (fetchedMap.containsKey(categoryId.toString())) {
      fetchedMap[categoryId.toString()]!;
    } else {
      _fetchRecipesByCategory(categoryId); // otherwise fetch the category
    }
  }

  Future<void> _fetchRecipesByCategory(String categoryId) async {
    isRecipesLoading = true;
    try {
      List<Map<String, dynamic>> response =
          await _categoryService.fetchRecipesByCategory(categoryId);
      recipes = response.map((e) => Recipe.fromJson(e['recipes']!)).toList();
      fetchedMap.addAll({categoryId: recipes});
      print(
          '[Category View Model] Recipes by category: ${fetchedMap[categoryId]}');
    } catch (e) {
      print('[Category View Model] Error fetching recipes by category: $e');
    } finally {
      isRecipesLoading = false;
      notifyListeners();
    }
  }
}
