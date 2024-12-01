import 'package:flutter/material.dart';
import 'package:got_food/common/models/user.dart';
import 'package:got_food/common/providers/userViewModel.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:provider/provider.dart';

import 'recipeForm.dart';

class CreateRecipePage extends StatelessWidget {
  const CreateRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserViewModel>(context).user;

    Widget? content;
    if (user == null) {
      content = Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text(
              'Login please to see ur profile',
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
