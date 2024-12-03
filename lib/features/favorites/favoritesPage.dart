import 'package:flutter/material.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/common/widgets/recipe-card/recipeImage.dart';
import 'package:got_food/common/widgets/recipe-card/recipesCard.dart';
import 'package:provider/provider.dart';

import '../../common/models/recipe.dart';
import '../../main.dart';
import 'favoritesViewModel.dart';


class FavoritesPage extends StatefulWidget {
  FavoritesPage({super.key});
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Recipe> recipes = [];

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FavoritesViewModel>(context);

    if(supabase.auth.currentUser != null) {
      viewModel.fetchFavorites(supabase.auth.currentUser!.id);
      recipes = viewModel.fetchedRecipes;
    }
    return CustomScaffold(
      title: 'Favorite Recipes',
      body: Column(
        children: [
        (recipes.isEmpty) ?
        Column() :
            Expanded(child:
        GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return
              RecipeImage(recipe: recipes[index], setFullView: false, favorite: true,);
        },
      ),),
],
    )
    );
  }
}