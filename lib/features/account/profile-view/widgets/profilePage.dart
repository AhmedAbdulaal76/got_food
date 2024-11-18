import 'package:flutter/material.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
        title: 'Profile', body: Center(child: Text('Profile Page')));
  }
}
