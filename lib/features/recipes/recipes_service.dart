import 'package:got_food/main.dart';

class RecipesService {
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
}
