import 'package:flutter/material.dart';
import 'package:got_food/common/models/recipe.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/common/widgets/layout/recipesLayout.dart';
import 'package:got_food/features/home/home-view/homeViewModel.dart';
import 'package:got_food/features/search/search-view/searchViewModel.dart';
import 'package:provider/provider.dart';

import 'filter/filter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isFilterApplied = false;
  List<Recipe>? recipes;

  void _applyFilter(List<Recipe>? recipes, {bool isFilterApplied = true}) {
    // apply filter
    setState(() {
      this.isFilterApplied = isFilterApplied;
      recipes = recipes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SearchViewModel>(context);

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
      content = Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Search results ${isFilterApplied ? '(filtered)' : ''}',
                  style: Theme.of(context).textTheme.titleLarge),
              Text(
                  '(${isFilterApplied ? viewModel.filteredRecipes.length : viewModel.recipes.length})',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      )),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 500,
            child: RecipesLayout(
                recipes: isFilterApplied
                    ? viewModel.filteredRecipes
                    : viewModel.recipes,
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
            builder: (ctx) => Filter(
                  onApplyFilter: _applyFilter,
                  isFilterApplied: isFilterApplied,
                )),
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
                    decoration: InputDecoration(
                      hintText: 'Search for recipes',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          searchController.clear();
                        },
                        child: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Search History
                  if (viewModel.searchHistory.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Search History 🕰',
                                style: Theme.of(context).textTheme.titleMedium),
                            TextButton(
                              onPressed: viewModel.clearHistory,
                              style: TextButton.styleFrom(
                                foregroundColor: Theme.of(context)
                                    .colorScheme
                                    .error, // Red color
                              ),
                              child: const Text('Clear History'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height:
                              50, // Restrict the height of the search history
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8, // Space between chips
                              children: viewModel.searchHistory
                                  .map(
                                    (query) => ActionChip(
                                      label: Text(query),
                                      onPressed: () {
                                        searchController.text = query;
                                        viewModel.searchRecipes(query);
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20, width: 50),
                  // search results
                  content,
                ],
              ),
            ),
          ),
        ));
  }
}
