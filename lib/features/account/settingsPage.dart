import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  get value => true;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Settings',
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.light_mode_rounded),
            title: Text('Toggle Light/Dark Mode'),
            trailing: Switch(value: value, onChanged: (v) {
              v = !value;
            }),
          )
        ],
      ),
    );
  }
}