// This class is responsible for fetching home-container related data from the database

import 'package:got_food/main.dart';

class HomeService {
  Future<dynamic> fetchCategories() async {
    try {
      var response = await supabase.from('categories').select();
      print('[Home Service] Categories fetched: $response');
      return response;
    } catch (e) {
      print('[Home Service] Error fetching categories: $e');
    }
  }

  Future<dynamic> fetchRecipes() async {
    try {
      var response = await supabase.from('recipes').select();
      print('[Home Service] Recipes fetched: $response');
      return response;
    } catch (e) {
      print('[Home Service] Error fetching recipes: $e');
    }
  }
}
