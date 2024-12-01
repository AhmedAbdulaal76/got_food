import 'package:flutter/material.dart';
import 'package:got_food/common/models/recipe.dart';

import '../search_service.dart';

class SearchViewModel extends ChangeNotifier {
  // This class is a view model for the search page to manage data fetched from search service

  final SearchService _searchService;

  SearchViewModel(this._searchService);

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
}