import 'package:flutter/material.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';

import 'recipeForm.dart';

class CreateRecipePage extends StatelessWidget {
  const CreateRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: RecipeForm(),
      ),
      title: 'Create Recipe',
    );
  }
}