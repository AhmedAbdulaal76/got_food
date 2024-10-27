import 'package:flutter/material.dart';
import 'package:got_food/common/style/themes/themeColors.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/common/widgets/recipe-card/recipesCard.dart';
import 'package:got_food/features/home/home-view/widgets/homeHeader.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Home Page",
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsDirectional.all(16),
          child: Column(
            children: [
              const HomeHeader(),
              const RecipesCard(
                imageUrl:
                    'https://www.dishgen.com/_next/image?url=https%3A%2F%2Fupcdn.io%2FW142hmp%2Frecipe%2Fuploads%2F2023%2F04%2F19%2FQuinoa-Skillet-7YXS.jpg.webp.crop&w=828&q=75',
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  Text('See All',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: ThemeColors.secondaryTextColor))
                ],
              ),
              // show categories
              const SizedBox(height: 16),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsetsDirectional.only(end: 8),
                      height: 20,
                      width: 140,
                      decoration: BoxDecoration(
                        color: ThemeColors.primaryColorLight,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
