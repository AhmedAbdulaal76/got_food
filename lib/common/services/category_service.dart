import 'package:got_food/main.dart';

class CategoryService {
  Future<dynamic> fetchRecipesByCategory(String categoryId) async {
    // Fetch recipes by category
    try {
      var response = await supabase
          .from('recipes_categories')
          .select("recipes:recipe_id(*)")
          .eq('category_id', categoryId);
      print("[Category Service] Recipes by category: $response");
      return response;
    } catch (e) {
      print('[Category Service] Error fetching recipes by category: $e');
    }
  }
}
