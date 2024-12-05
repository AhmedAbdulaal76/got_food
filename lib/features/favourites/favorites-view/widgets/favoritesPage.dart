import 'package:flutter/material.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/common/widgets/recipe-card/recipesCard.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';
import '../favoritesViewModel.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  // List<Recipe> recipes = [];

  @override
  void initState() {
    // TODO: implement initState
    final viewModel = Provider.of<FavoritesViewModel>(context, listen: false);
    if (supabase.auth.currentUser != null) {
      viewModel.fetchFavorites(supabase.auth.currentUser!.id);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FavoritesViewModel>(context);

    Widget? content;
    if (supabase.auth.currentUser == null) {
      content = Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text(
              'Login to view your favorite recipes!!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    } else {
      content = RefreshIndicator(
        onRefresh: () {
          viewModel.fetchedRecipes.clear();
          return viewModel.fetchFavorites(supabase.auth.currentUser!.id);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              viewModel.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : (viewModel.fetchedRecipes.isEmpty)
                      ? const Center(child: Text('No favorite recipes yet'))
                      : Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.7,
                            ),
                            itemCount: viewModel.fetchedRecipes.length,
                            itemBuilder: (context, index) {
                              return RecipesCard(
                                recipe: viewModel.fetchedRecipes[index],
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 10),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 4),
                              );
                            },
                          ),
                        ),
            ],
          ),
        ),
      );
    }
    return CustomScaffold(title: 'Favorite Recipes', body: content);
  }
}
