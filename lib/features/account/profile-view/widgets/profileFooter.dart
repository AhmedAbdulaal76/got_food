import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:got_food/common/style/theme.dart';
import 'package:got_food/common/widgets/layout/recipesLayout.dart';
import 'package:got_food/features/account/profile-view/profileViewModel.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../common/models/recipe.dart';
import '../../../../main.dart';

class ProfileFooter extends StatelessWidget {
  ProfileFooter({super.key});


  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        SizedBox(height: 35),
        ListTile(
          leading: Icon(Icons.settings, color: GotFoodTheme.kColorScheme.primary),
          title: Text('Settings', style: TextStyle(fontSize: 18, color: Colors.black)),
          trailing: Icon(Icons.arrow_forward_ios_outlined, size: 16,),
          onTap: () async {
            Navigator.pushNamed(context, '/profile/settings');
          },
        ),
        ListTile(
          leading: Icon(Icons.logout, color: GotFoodTheme.kColorScheme.primary),
          title: Text('Logout', style: TextStyle(fontSize: 18, color: Colors.red)),
          onTap: () async {
                    await supabase.auth.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
                    },
        ),
      ]
    );
  }
}
