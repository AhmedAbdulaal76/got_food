import 'package:flutter/material.dart';
import 'package:got_food/common/models/category.dart';
import 'package:got_food/common/providers/CategoryViewModel.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/common/widgets/layout/recipesLayout.dart';
import 'package:provider/provider.dart';

class CategoryDetailsPage extends StatelessWidget {
  // final Category category;

  const CategoryDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as Category;

    final CategoryViewModel viewModel = Provider.of<CategoryViewModel>(context);

    viewModel.fetchRecipesByCategory(category.categoryId);

    Widget content;
    if (viewModel.isRecipesLoading) {
      content = const CircularProgressIndicator();
    } else if (viewModel.fetchedMap[category.categoryId]!.isEmpty) {
      content = const Center(child: Text('No recipes found'));
    } else {
      content = RecipesLayout(
          recipes: viewModel.fetchedMap[category.categoryId]!,
          setFullView: true);
    }
    return CustomScaffold(title: category.name, body: content);
  }
}
