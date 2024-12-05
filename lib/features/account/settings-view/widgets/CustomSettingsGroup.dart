import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/material.dart';

class CustomSettingsGroup extends StatelessWidget {
  final List<SettingsItem> items;

  CustomSettingsGroup({required this.items,  Color? backgroundColor,  EdgeInsets? margin});

  @override
  Widget build(BuildContext context) {
    return SettingsGroup(
      backgroundColor: Theme.of(context).highlightColor, // Default background color
      margin: const EdgeInsets.all(10), // Default margin
      items: items,
    );
  }
}
