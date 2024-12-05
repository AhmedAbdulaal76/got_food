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
