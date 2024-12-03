import 'package:got_food/main.dart';

class SearchService {
  // This class is a service for the search page to manage data fetching

  // This method is responsible for fetching recipes from the database based on the search query
  Future<dynamic> searchRecipes(String query) async {
    try {
      var response =
          await supabase.from('recipes').select().textSearch('name', query);
      print('[Search Service] Recipes fetched: $response');
      return response;
    } catch (e) {
      print('[Search Service] Error fetching recipes: $e');
    }
  }
}
