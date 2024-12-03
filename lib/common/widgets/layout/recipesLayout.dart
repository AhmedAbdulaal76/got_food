import 'package:flutter/material.dart';
import 'package:got_food/common/models/recipe.dart';
import 'package:got_food/common/widgets/recipe-card/recipesCard.dart';

class RecipesLayout extends StatelessWidget {
  RecipesLayout(
      {super.key,
      required this.recipes,
      this.setFullView = false,
      this.clipBehavior});

  final List<Recipe> recipes;
  bool setFullView;
  Clip? clipBehavior;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: setFullView ? Axis.vertical : Axis.horizontal,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: setFullView ? 1.3 : 1.2,
      ),
      clipBehavior: clipBehavior ?? Clip.none,
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return RecipesCard(recipe: recipes[index], setFullView: setFullView);
      },
    );
  }
}
