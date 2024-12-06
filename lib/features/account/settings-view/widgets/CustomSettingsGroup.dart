import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/material.dart';

class CustomSettingsGroup extends StatelessWidget {
  final List<SettingsItem> items;
  final Color? backgroundColor;
  final EdgeInsets? margin;

  const CustomSettingsGroup({
    super.key,
    required this.items,
    this.backgroundColor,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsGroup(
      backgroundColor: backgroundColor ?? Theme.of(context).highlightColor,
      // Use provided color or default
      margin: margin ?? const EdgeInsets.all(10),
      // Use provided margin or default
      items: items,
    );
  }
}
