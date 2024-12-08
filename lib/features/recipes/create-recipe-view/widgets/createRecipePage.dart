import 'package:flutter/material.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/main.dart';

import 'recipeForm.dart';

class CreateRecipePage extends StatelessWidget {
  const CreateRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget? content;
    if (supabase.auth.currentSession == null) {
      content = Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text(
              'Login to create delicous recipes!!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    } else {
      content = const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: RecipeForm(),
      );
    }

    return CustomScaffold(
      body: content,
      title: 'Create Recipe',
    );
  }
}
