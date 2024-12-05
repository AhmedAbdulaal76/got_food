import 'package:flutter/material.dart';
import 'package:got_food/common/models/category.dart';
import 'package:got_food/common/providers/CategoryViewModel.dart';
import 'package:provider/provider.dart';

class TabItem extends StatelessWidget {
  const TabItem(
      {super.key,
      required this.onTabSelected,
      required this.categories,
      this.selectedIndex = 0});

  final List<Category> categories;
  final int selectedIndex;
  final void Function(int) onTabSelected;
  @override
  Widget build(BuildContext context) {
    CategoryViewModel viewModel = Provider.of<CategoryViewModel>(context);
    return SizedBox(
      height: 41,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              viewModel.fetchRecipesByCategory(categories[index].categoryId);
              onTabSelected(index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300), // Animation duration
              curve: Curves.easeInOut, // Animation curve
              height: 41,
              width: 124,
              margin: const EdgeInsetsDirectional.only(end: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? selectedIndex == index
                        ? Theme.of(context).colorScheme.surface
                        : Theme.of(context).colorScheme.primary
                    : selectedIndex == index // for light theme
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  categories[index].name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight:
                            selectedIndex == index ? FontWeight.bold : null,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? selectedIndex == index
                                ? Theme.of(context).colorScheme.onSurface
                                : Theme.of(context).colorScheme.onPrimary
                            : selectedIndex == index // for light theme
                                ? Colors.white
                                : Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
