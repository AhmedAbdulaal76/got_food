import 'package:flutter/material.dart';
import 'package:got_food/common/models/recipe.dart';

import '../search_service.dart';
import 'search_history_repository.dart';

class SearchViewModel extends ChangeNotifier {
  // This class is a view model for the search page to manage data fetched from search service

  final SearchService _searchService;

  SearchViewModel(this._searchService, this._repository) {
    loadSearchHistory();
  }

  List<double>? caloriesValues;
  set setCaloriesValues(List<double> values) {
    caloriesValues = values;
  }

  List<double>? timeValues;
  set setTimeValues(List<double> values) {
    timeValues = values;
  }

  List<String> _searchHistory = [];
  List<String> get searchHistory => List.unmodifiable(_searchHistory);
  List<Recipe> recipes = [];
  bool isLoading = false;
  bool searched = false;
  String searchQuery = '';
  Future<void> searchRecipes(String query) async {
    isLoading = true;
    searched = true;
    try {
      List<dynamic> response = await _searchService.searchRecipes(query);
      recipes = response.map((e) => Recipe.fromJson(e)).toList();
      addSearchQuery(query);
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
    } catch (e) {
      print('[Search View Model] Error fetching filtered recipes: $e');
    } finally {
      isLoading = false;
      // notifyListeners();
    }
  }

  final SearchHistoryRepository _repository;

  Future<void> loadSearchHistory() async {
    _searchHistory = await _repository.getSearchHistory();
    notifyListeners();
  }

  Future<void> addSearchQuery(String query) async {
    query = query.trim(); // Remove leading and trailing spaces
    if (query.isEmpty) return;
    searchQuery = query;
    // Add query to search history if it doesn't already exist && save to shared preferences
    if (!_searchHistory.contains(query)) {
      _searchHistory.add(query);
      await _repository.saveSearchHistory(_searchHistory);
      notifyListeners();
    }
  }

  Future<void> clearHistory() async {
    _searchHistory.clear();
    await _repository.clearSearchHistory();
    notifyListeners();
  }
}
