import 'package:got_food/main.dart';

class RecipesService {
  // fetch recipe ingredients
  Future<dynamic> fetchRecipeIngredients(String recipeId) async {
    try {
      var res = await supabase
          .from('recipe_ingredients')
          .select('quantity, unit, ingredients:ingredient_id(*)')
          .eq('recipe_id', recipeId);
      print('[Recipe Service] Recipe ingredients fetched: $res');
      return res;
    } catch (e) {
      print(
          '[Recipe Details View Model] Error fetching recipe ingredients: $e');
    }
  }

  // fetch recipe creator info
  // Future<dynamic> fetchRecipeCreator(String recipId) async {
  //   try {
  //     var res = await supabase
  //         .from('recipes')
  //         .select('profiles:user_uuid(*)')
  //         .eq('recipe_id', recipId);
  //     print('[Recipe Service] Recipe creator fetched: $res');
  //     return res;
  //   } catch (e) {
  //     print('[Recipe Service] Error fetching recipe creator: $e');
  //
  // }

  // fetch recipe creator info by user id in profiles
  Future<dynamic> fetchRecipeCreator(String userId) async {
    try {
      var res =
          await supabase.from('profiles').select('*').eq('user_uuid', userId);
      print('[Recipe Service] Recipe creator fetched: $res');
      return res;
    } catch (e) {
      print('[Recipe Service] Error fetching recipe creator: $e');
    }
  }
}
