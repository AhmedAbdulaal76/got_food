import 'package:flutter/material.dart';
import 'package:got_food/common/models/recipe.dart';
import 'package:got_food/common/widgets/recipe-card/recipesCard.dart';
import 'package:provider/provider.dart';

import '../../../features/favorites/favoritesViewModel.dart';
import '../../../main.dart';

class RecipesLayout extends StatelessWidget {
  RecipesLayout({super.key, required this.recipes, this.setFullView = false});

  final List<Recipe> recipes;
  bool setFullView;
  List<Recipe> userFavoriteRecipes = [];
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FavoritesViewModel>(context);
    if(supabase.auth.currentUser != null){
      viewModel.fetchFavorites(supabase.auth.currentUser!.id);
      userFavoriteRecipes = viewModel.fetchedRecipes;
    };
    return GridView.builder(
      scrollDirection: setFullView ? Axis.vertical : Axis.horizontal,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: setFullView ? 1.3 : 1.2,
      ),
      clipBehavior: Clip.none,
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return RecipesCard(recipe: recipes[index], setFullView: setFullView, favorite: userFavoriteRecipes.contains(recipes[index]),);
      },
    );
  }
}
