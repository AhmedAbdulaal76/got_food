import 'package:flutter/material.dart';
import 'package:got_food/common/models/recipe.dart';

import '../favorites_service.dart';

class FavoritesViewModel extends ChangeNotifier {
  late BuildContext ctx;
  set context(BuildContext context) {
    ctx = context;
  }

  final FavoritesService _favoritesService;
  List<Recipe> fetchedRecipes = [];
  FavoritesViewModel(this._favoritesService);

  Future<void> addToFavorites(String userId, Recipe recipe) async {
    try {
      await _favoritesService.addToFavorites(userId, recipe);
      fetchedRecipes.add(recipe);
      // show snackbar
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          content: Text('Added to favorites'),
        ),
      );
      notifyListeners();
    } catch (e) {
      print('[Favorites Viewmodel] Error adding to favorites.');
      if (e.toString().contains('23505')) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(
            content: Text('Recipe already in favorites'),
          ),
        );
      }
    }
  }

  bool isFavorite(String recipeId) {
    return fetchedRecipes.any((element) => element.recipeId == recipeId);
  }

  void removeFromFavorites(String userId, Recipe recipe) async {
    try {
      await _favoritesService.removeFromFavorites(userId, recipe);
      fetchedRecipes
          .removeWhere((element) => element.recipeId == recipe.recipeId);
      print('[Favorites Viewmodel] Removed from favorites: $recipe');
      // show snackbar
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: const Text('Removed from favorites'),
          action: SnackBarAction(
            label: 'Undo',
            textColor: Theme.of(ctx).colorScheme.surface,
            onPressed: () {
              addToFavorites(userId, recipe);
            },
          ),
        ),
      );
      notifyListeners();
    } catch (e) {
      print('[Favorites Viewmodel] Error removing from favorites.');
    }
  }

  bool isLoading = true;
  Future<void> fetchFavorites(String userId) async {
    isLoading = true;
    try {
      List<dynamic> response = await _favoritesService.fetchFavorites(userId);
      fetchedRecipes =
          response.map((e) => Recipe.fromJson(e['recipes'])).toList();
      print('[Favorites Viewmodel] Fetched recipes: $fetchedRecipes');
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print('[Favorites Viewmodel] Error fetching. $e');
    }
  }
}
