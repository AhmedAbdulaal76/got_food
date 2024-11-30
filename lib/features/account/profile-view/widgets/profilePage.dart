import 'package:flutter/material.dart';
import 'package:got_food/common/style/theme.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/features/account/profile-view/widgets/profileBody.dart';
import 'package:got_food/features/account/profile-view/widgets/profileHeader.dart';
import 'package:got_food/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final User? user = Supabase.instance.client.auth.currentUser;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Profile',
      body: Container(color: Colors.white, child: SingleChildScrollView(
            child: supabase.auth.currentUser != null
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                    ProfileHeader(),
                    const SizedBox(height: 30),
                    ProfileBody(),
                ],
              ),
            )
          : Center(
              child: Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text('Login please to see ur profile')),
            )),
      )));
  }
}
