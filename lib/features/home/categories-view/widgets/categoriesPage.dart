import 'package:flutter/material.dart';
import 'package:got_food/common/widgets/category/categoryCard.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/features/home/home-view/homeViewModel.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = Provider.of<HomeViewModel>(context);

    return CustomScaffold(
      title: 'Categories',
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          // childAspectRatio: 3 / 2,
          // childAspectRatio: 1,
        ),
        itemCount: viewModel.categories.length,
        itemBuilder: (context, index) {
          return CategoryCard(category: viewModel.categories[index]);
        },
      ),
    );
  }
}
