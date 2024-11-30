import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:got_food/common/style/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../main.dart';

class ProfileBody extends StatelessWidget {
  ProfileBody({super.key});

  final User? user = Supabase.instance.client.auth.currentUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child:
        Text('My Recipes',
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.alphaBlend(Colors.black.withOpacity(0.3), GotFoodTheme.kColorScheme.primary),
          fontSize: 22
        ),),
        ),

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
