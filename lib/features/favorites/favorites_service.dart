import 'package:got_food/main.dart';

import '../../common/models/recipe.dart';

class FavoritesService {

  void addToFavorites(String userId, Recipe recipe) async {
    try {
      var res = await supabase.from('user_favourites').insert(
        {
          'user_uuid': userId,
          'recipe_id': recipe.recipeId
        }
      ).select('recipe_id');
      print('[Favorites Service] Recipe Favorited: $res');
    } catch (e) {
      print(
          '[Favorites Service] Error favoriting recipe: $e');
    }
  }

  void removeFromFavorites(String userId, Recipe recipe) async {
    try {
      var res = await supabase.from('user_favourites').delete()
          .eq('user_uuid', userId).eq('recipe_id', recipe.recipeId);
      print('[Favorites Service] Recipe Unfavorited: $res');
    } catch (e) {
      print(
          '[Favorites Service] Error unfavoriting recipe: $e');
    }
  }

  Future<dynamic> fetchFavorites(String userId) async {
    try {
      var res = await supabase.from('user_favourites').select('recipes:recipe_id(*)')
          .eq('user_uuid', userId);
      print('[Favorites Service] Favorites fetched: $res');
      print('Response: ${res}');
      return res;
    } catch (e) {
      print(
          '[Favorites Service] Error fetching favorites: $e');
    }
  }
}
