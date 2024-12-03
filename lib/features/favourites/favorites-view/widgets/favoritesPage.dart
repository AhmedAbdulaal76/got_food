import 'package:flutter/material.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/common/widgets/recipe-card/recipeImage.dart';
import 'package:provider/provider.dart';

import '../../../../common/models/recipe.dart';
import '../../../../main.dart';
import '../favoritesViewModel.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Recipe> recipes = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final viewModel = Provider.of<FavoritesViewModel>(context);
    if (supabase.auth.currentUser != null) {
      viewModel.fetchFavorites(supabase.auth.currentUser!.id);
      recipes = viewModel.fetchedRecipes;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // if (supabase.auth.currentUser != null && ) {
    //   viewModel.fetchFavorites(supabase.auth.currentUser!.id);
    //   recipes = viewModel.fetchedRecipes;
    // }

    Widget content = Column(
      children: [
        (recipes.isEmpty)
            ? const Column()
            : Expanded(
                child: GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    return RecipeImage(
                      recipe: recipes[index],
                      setFullView: false,
                    );
                  },
                ),
              ),
      ],
    );

    return CustomScaffold(title: 'Favorite Recipes', body: content);
  }
}
