// This class is a view model for the home page to manage data fetched from home service

import 'package:flutter/material.dart';
import 'package:got_food/common/models/category.dart';
import 'package:got_food/common/models/recipe.dart';
import 'package:got_food/features/home/home_service.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeService _homeService;

  HomeViewModel(this._homeService);

  List<Category> categories = [];
  Future<void> fetchCategories() async {
    try {
      List<dynamic> response = await _homeService.fetchCategories();
      categories = response.map((e) => Category.fromJson(e)).toList();
    } catch (e) {
      print('[Home View Model] Error fetching categories: $e');
    } finally {
      notifyListeners();
    }
  }

  List<Recipe> recipes = [];
  Future<void> fetchRecipes() async {
    try {
      List<dynamic> response = await _homeService.fetchRecipes();
      recipes = response.map((e) => Recipe.fromJson(e)).toList();
    } catch (e) {
      print('[Home View Model] Error fetching recipes: $e');
    } finally {
      notifyListeners();
    }
  }
}
