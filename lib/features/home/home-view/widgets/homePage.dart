import 'package:flutter/material.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/features/home/home-view/widgets/homeHeader.dart';
import 'package:got_food/features/home/home-view/widgets/recipe-card/recipesCard.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      title: "Home Page",
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.all(16),
          child: Column(
            children: [
              HomeHeader(),
              RecipesCard(),
            ],
          ),
        ),
      ),
    );
  }
}
