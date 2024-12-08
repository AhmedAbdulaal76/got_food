import 'package:flutter/material.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/common/widgets/layout/recipesLayout.dart';
import 'package:got_food/features/home/home-view/homeViewModel.dart';
import 'package:got_food/features/search/search-view/searchViewModel.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SearchViewModel>(context);
    // form key
    final formKey = GlobalKey<FormState>();

    // controller
    final TextEditingController searchController =
        TextEditingController(text: viewModel.searchQuery);

    Widget content;
    if (viewModel.isLoading) {
      content = const CircularProgressIndicator();
    } else if (viewModel.recipes.isEmpty) {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  viewModel.searched
                      ? 'No recipes found'
                      : 'Search for delicous recipes',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(width: 10),
              Icon(viewModel.searched ? Icons.search_off : Icons.search),
            ],
          ),
          // checkout favourite recipes
          const SizedBox(height: 20),
          Text(
            'Checkout featured recipes 😊',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 500,
            child: RecipesLayout(
              recipes:
                  Provider.of<HomeViewModel>(context, listen: false).recipes,
              setFullView: true,
              clipBehavior: Clip.hardEdge,
              // setFullView: true,
            ),
          )
        ],
      );
    } else {
      // content = RecipesLayout(recipes: viewModel.recipes);
      content = Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Search results',
                  style: Theme.of(context).textTheme.titleLarge),
              Text('(${viewModel.recipes.length})',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      )),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 500,
            child: RecipesLayout(
                recipes: viewModel.recipes,
                setFullView: true,
                clipBehavior: Clip.hardEdge),
          )
        ],
      );
    }

    // have a column of search bar, search results
    return CustomScaffold(
      title: 'Search',
      actionIcon: const Icon(Icons.filter_list),
      // on press show modal bottom sheet for filtering recipes through calories & time
      actionFunc: () => showModalBottomSheet(
        context: context,
        builder: (context) {
          final formKey = GlobalKey<FormState>();
          RangeValues calorieRange = const RangeValues(100, 500);
          RangeValues timeRange = const RangeValues(10, 60);

          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Filter recipes',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),

                  // Range Slider for Calories
                  Text(
                      'Calories Range: ${calorieRange.start.toInt()} - ${calorieRange.end.toInt()}'),
                  RangeSlider(
                    values: calorieRange,
                    min: 0,
                    max: 1000,
                    divisions: 20,
                    labels: RangeLabels(
                      calorieRange.start.round().toString(),
                      calorieRange.end.round().toString(),
                    ),
                    onChanged: (RangeValues newRange) {
                      calorieRange = newRange;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Range Slider for Time
                  Text(
                      'Time Range (minutes): ${timeRange.start.toInt()} - ${timeRange.end.toInt()}'),
                  RangeSlider(
                    values: timeRange,
                    min: 0,
                    max: 120,
                    divisions: 24,
                    labels: RangeLabels(
                      timeRange.start.round().toString(),
                      timeRange.end.round().toString(),
                    ),
                    onChanged: (RangeValues newRange) {
                      timeRange = newRange;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Filter Button
                  ElevatedButton(
                    onPressed: () {
                      // Apply filter
                      if (formKey.currentState!.validate()) {
                        final filteredRecipes =
                            viewModel.recipes.where((recipe) {
                          return recipe.calories >= calorieRange.start &&
                              recipe.calories <= calorieRange.end &&
                              recipe.time >= timeRange.start &&
                              recipe.time <= timeRange.end;
                        }).toList();

                        // Update the UI or perform any action with the filtered recipes
                        viewModel.updateFilteredRecipes(filteredRecipes);

                        Navigator.pop(context); // Close the modal
                      }
                    },
                    child: const Text('Filter'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Expanded(
            child: Column(
              children: [
                // search bar
                TextFormField(
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: (value) {
                    viewModel.searchRecipes(value);
                  },
                  onChanged: (value) {
                    if (value.isEmpty) {}
                  },
                  decoration: InputDecoration(
                    hintText: 'Search for recipes',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: GestureDetector(
                      child: const Icon(Icons.clear),
                      onTap: () {
                        searchController.clear();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // search results
                content,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
