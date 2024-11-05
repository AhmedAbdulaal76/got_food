import 'package:flutter/material.dart';
import 'package:got_food/common/models/category.dart';
import 'package:got_food/common/providers/CategoryViewModel.dart';
import 'package:got_food/common/widgets/layout/recipesLayout.dart';
import 'package:got_food/features/home/home-view/widgets/categoryTabs/tabItem.dart';
import 'package:provider/provider.dart';

class CategoryTabs extends StatefulWidget {
  const CategoryTabs({super.key, required this.categories});

  final List<Category> categories;

  @override
  State<CategoryTabs> createState() => _CategoryTabsState();
}

class _CategoryTabsState extends State<CategoryTabs> {
  int selectedIndex = 0;

  void onTabSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    print('The selected index is: $selectedIndex');
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CategoryViewModel>(context);

    viewModel
        .fetchRecipesByCategory(widget.categories[selectedIndex].categoryId);

    Widget content;
    if (viewModel.isRecipesLoading) {
      content = const CircularProgressIndicator();
    } else {
      content = Column(
        children: [
          // category tabs
          TabItem(
            onTabSelected: onTabSelected,
            categories: widget.categories,
            selectedIndex: selectedIndex,
          ),
          viewModel.fetchedMap[widget.categories[selectedIndex].categoryId]!
                  .isEmpty
              // no recipes message
              ? Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(
                    'No recipes for this category yet :(',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              // recipes layout
              : SizedBox(
                  height: 270,
                  child: viewModel.isRecipesLoading
                      ? const CircularProgressIndicator()
                      : RecipesLayout(
                          recipes: viewModel.fetchedMap[
                              widget.categories[selectedIndex].categoryId]!),
                ),
        ],
      );
    }

    return content;
  }
}
