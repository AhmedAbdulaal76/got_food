import 'package:flutter/material.dart';
import 'package:got_food/common/models/recipe.dart';
import 'package:provider/provider.dart';

import '../../recipeDetailsViewModel.dart';
import 'tabItem.dart';

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
    Widget sectionContent = const Center(child: Text('temp'));
    if (viewModel.isLoading) {
      content = const CircularProgressIndicator();
    } else {
      content = Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // category tabs
          TabItem(
            onTabSelected: onTabSelected,
            list: const ['Ingredients', 'Instructions'],
            viewModel: viewModel,
            selectedIndex: selectedIndex,
          ),
          SizedBox(
              height: 270,
              child: viewModel.isLoading
                  ? const CircularProgressIndicator()
                  : sectionContent),
        ],
      );
    }

    return content;
  }
}
