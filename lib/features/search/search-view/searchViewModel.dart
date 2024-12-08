import 'package:flutter/material.dart';
import 'package:got_food/common/models/recipe.dart';

import '../search_service.dart';

class SearchViewModel extends ChangeNotifier {
  // This class is a view model for the search page to manage data fetched from search service

  final SearchService _searchService;

  SearchViewModel(this._searchService);

  List<double>? caloriesValues;
  set setCaloriesValues(List<double> values) {
    caloriesValues = values;
  }

  List<double>? timeValues;
  set setTimeValues(List<double> values) {
    timeValues = values;
  }

  List<Recipe> recipes = [];
  bool isLoading = false;
  bool searched = false;
  String searchQuery = '';
  Future<void> searchRecipes(String query) async {
    searchQuery = query;
    isLoading = true;
    searched = true;
    try {
      List<dynamic> response = await _searchService.searchRecipes(query);
      recipes = response.map((e) => Recipe.fromJson(e)).toList();
    } catch (e) {
      print('[Search View Model] Error searching recipes: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void updateFilteredRecipes(List<Recipe> filteredRecipes) {
    recipes = filteredRecipes;
    notifyListeners();
  }

  List<Recipe> filteredRecipes = [];

  void fetchFilteredRecipes(double minCalories, double maxCalories,
      double minTime, double maxTime) async {
    isLoading = true;
    try {
      // locally filter recipes based on calories & time
      filteredRecipes = recipes
          .where((recipe) =>
              recipe.calories >= minCalories &&
              recipe.calories <= maxCalories &&
              recipe.time >= minTime &&
              recipe.time <= maxTime)
          .toList();
      // filteredRecipes = recipes
      //     .where((recipe) =>
      //         recipe.calories >= minCalories && recipe.calories <= maxCalories)
      //     .toList();
    } catch (e) {
      print('[Search View Model] Error fetching filtered recipes: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
