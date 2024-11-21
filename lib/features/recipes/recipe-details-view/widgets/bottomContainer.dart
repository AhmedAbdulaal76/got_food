import 'package:flutter/material.dart';
import 'package:got_food/common/models/recipe.dart';

import 'recipeHeader.dart';
import 'tabs/ingredientsTab.dart';
import 'tabs/instructionsTab.dart';

class BottomContainer extends StatelessWidget {
  const BottomContainer({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 240),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        // shadow on the image
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              children: [
                RecipeHeader(
                  recipe: recipe,
                ),
                // tabview for ingredients and instructions
                const TabBar(tabs: [
                  Tab(text: "Ingredients"),
                  Tab(text: "Instructions"),
                ]),
                const TabBarView(
                  children: <Widget>[
                    IngredientsTab(),
                    InstructionsTab(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
