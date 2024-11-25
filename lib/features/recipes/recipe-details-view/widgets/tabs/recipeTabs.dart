import 'package:flutter/material.dart';
import 'package:got_food/common/models/recipe.dart';
import 'package:got_food/features/recipes/recipe-details-view/widgets/tabs/ingredientsSection.dart';
import 'package:provider/provider.dart';

import '../../recipeDetailsViewModel.dart';
import 'tabItems.dart';

class RecipeTabs extends StatefulWidget {
  const RecipeTabs({super.key, required this.recipe});

  final Recipe recipe;

  @override
  State<RecipeTabs> createState() => _RecipeTabsState();
}

class _RecipeTabsState extends State<RecipeTabs> {
  int selectedIndex = 0;

  void onTabSelected(ChangeNotifier viewModel, int index) {
    if (viewModel is RecipeDetailsViewModel) {
      viewModel.fetchRecipeIngredients(widget.recipe.recipeId);
    }
    setState(() {
      selectedIndex = index;
    });
    // print('The selected index is: $selectedIndex');
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RecipeDetailsViewModel>(context);

    viewModel.fetchRecipeIngredients(widget.recipe.recipeId);

    Widget content;
    Widget sectionContent = viewModel.isLoading
        ? const CircularProgressIndicator()
        : selectedIndex == 0
            ? IngredientsSection(
                ingredients: viewModel.fetchedMap[widget.recipe.recipeId]!)
            : Text(
                widget.recipe.instructions,
                style: Theme.of(context).textTheme.bodyLarge,
              );

    if (viewModel.isLoading) {
      content = const CircularProgressIndicator();
    } else {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Category tabs
          TabItems(
            onTabSelected: onTabSelected,
            list: const ['Ingredients', 'Instructions'],
            viewModel: viewModel,
            selectedIndex: selectedIndex,
          ),
          const SizedBox(height: 16),
          // Section content
          SizedBox(
              height: 260,
              child: viewModel.isLoading
                  ? const CircularProgressIndicator()
                  : sectionContent),
        ],
      );
    }

    return content;
  }
}
