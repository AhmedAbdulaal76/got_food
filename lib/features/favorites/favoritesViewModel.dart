import 'package:flutter/material.dart';
import 'package:got_food/common/models/recipe.dart';
import 'package:got_food/common/services/category_service.dart';
import 'package:got_food/features/favorites/favorites_service.dart';

class FavoritesViewModel extends ChangeNotifier {
  final FavoritesService _favoritesService;
  List<Recipe> fetchedRecipes = [];
  FavoritesViewModel(this._favoritesService);


  Future<void> addToFavorites(String userId, Recipe recipe) async {
      _favoritesService.addToFavorites(userId, recipe);
      fetchedRecipes.add(recipe);
      notifyListeners();
  }


void removeFromFavorites(String userId, Recipe recipe) async {
  _favoritesService.removeFromFavorites(userId, recipe);
  fetchedRecipes.remove(recipe);
  notifyListeners();
  }

  Future<void> fetchFavorites(String userId) async {
    try{
      List<dynamic>  response = await _favoritesService.fetchFavorites(userId);
    fetchedRecipes = response.map((e) => Recipe.fromJson(e['recipes'])).toList();
    print('[Favorites Viewmodel] Fetched recipes: ${fetchedRecipes}');
    notifyListeners();
  }catch (e){
      print('[Favorites Viewmodel] Error fetching. ${e}');
    }
    }
}
