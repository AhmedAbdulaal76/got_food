import 'package:flutter/material.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/main.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Profile',
      body: supabase.auth.currentUser != null
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('welcome to your Profile Page'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await supabase.auth.signOut();
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false);
                    },
                    child: const Text('Logout'),
                  ),
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
                child: const Text(
                  'Login please to see ur profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )),
    );
  }
}
