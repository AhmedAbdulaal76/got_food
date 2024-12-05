
import 'package:got_food/main.dart';

class ProfileService {
  Future<dynamic> fetchRecipesByUserId(String userId) async {
    // Fetch recipes by category
    try {
      var response = await supabase
          .from('recipes')
          .select()
          .eq('creator_id', userId);
      print("[Profile Service] Recipes by UserId: $response");
      return response;
    } catch (e) {
      print('[Profile ViewModel Service] Error fetching recipes by UserId: $e');
    }
  }
}