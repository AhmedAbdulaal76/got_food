// This class is a view model for the home page to manage data fetched from home service

import 'package:flutter/material.dart';
import 'package:got_food/features/home/home_service.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeService _homeService;

  HomeViewModel(this._homeService);

  List<dynamic> categories = [];

  Future<void> fetchCategories() async {
    var response = await _homeService.fetchCategories();
    if (response != null) {
      categories = response;
      notifyListeners();
    }
  }

  List<dynamic> recipes = [];
  bool isRecipesLoading = true;

  Future<void> fetchRecipes() async {
    try {
      var response = await _homeService.fetchRecipes();
      if (response != null) {
        recipes = response;
      }
    } catch (e) {
      print('[Home View Model] Error fetching recipes: $e');
    } finally {
      isRecipesLoading = false;
      notifyListeners();
    }
  }
}
