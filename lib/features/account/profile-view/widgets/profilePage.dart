import 'package:flutter/material.dart';
import 'package:got_food/common/style/theme.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/features/account/profile-view/widgets/profileFooter.dart';
import 'package:got_food/features/account/profile-view/widgets/profileHeader.dart';
import 'package:got_food/main.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../common/widgets/layout/recipesLayout.dart';
import '../profileViewModel.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final User? user = Supabase.instance.client.auth.currentUser;
  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context);
    if (user != null) {
      profileViewModel.fetchRecipesByUserId(user!.id);
    }
    return CustomScaffold(
        title: 'Profile',
        body: supabase.auth.currentUser != null
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ProfileHeader(),
                      const SizedBox(height: 30),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'My Recipes',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.alphaBlend(
                                  Colors.black.withOpacity(0.3),
                                  GotFoodTheme.kColorScheme.primary),
                              fontSize: 22),
                        ),
                      ),
                      const SizedBox(height: 16),
                      profileViewModel.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : profileViewModel.recipes.isEmpty
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/create-recipe');
                                      },
                                      child: const Text(
                                        'Create your first recipe',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 270,
                                  child: RecipesLayout(
                                      recipes: profileViewModel
                                          .fetchedMap[user?.id]!),
                                ),
                      ProfileFooter(),
                    ],
                  ),
                ),
              )
            : Center(
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
              )));
  }
}
