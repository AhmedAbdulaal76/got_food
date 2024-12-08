import 'package:flutter/material.dart';
import 'package:got_food/common/models/category.dart';
import 'package:got_food/common/models/recipe.dart';
import 'package:got_food/common/providers/CategoryViewModel.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/common/widgets/layout/recipesLayout.dart';
import 'package:got_food/common/widgets/other/filter/filter.dart';
import 'package:provider/provider.dart';

class CategoryDetailsPage extends StatefulWidget {
  // final Category category;

  const CategoryDetailsPage({super.key});

  @override
  State<CategoryDetailsPage> createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  bool isFilterApplied = false;
  List<Recipe> filteredRecipes = [];

  void _applyFilter(List<Recipe> recipes, {bool isFilterApplied = true}) {
    // apply filter
    setState(() {
      this.isFilterApplied = isFilterApplied;
      filteredRecipes = recipes;
    });
  }

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
      content = Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                      'Recipes found ${isFilterApplied ? '(filtered)' : ''} (${isFilterApplied ? filteredRecipes.length : viewModel.fetchedMap[category.categoryId]!.length})',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(width: 10),
                  const Icon(Icons.fastfood),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: RecipesLayout(
                  recipes: isFilterApplied
                      ? filteredRecipes
                      : viewModel.fetchedMap[category.categoryId]!,
                  setFullView: true,
                  clipBehavior: Clip.hardEdge,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return CustomScaffold(
        title: category.name,
        actionIcon: const Icon(Icons.filter_list),
        // on press show modal bottom sheet for filtering recipes through calories & time
        actionFunc: () => showModalBottomSheet(
            context: context,
            builder: (ctx) => Filter(
                  recipes: viewModel.fetchedMap[category.categoryId],
                  onApplyFilter: _applyFilter,
                  isFilterApplied: isFilterApplied,
                )),
        body: content);
  }
}
