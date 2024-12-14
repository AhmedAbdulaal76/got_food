import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/material.dart';

class CustomSettingsItem extends SettingsItem {
  CustomSettingsItem({
    required super.title,
    super.subtitle,
    required IconData icon,
    super.onTap,
    super.trailing,
    Color? iconColor, // Make iconColor nullable
    required BuildContext context, // Add context parameter
  }) : super(
          icons: icon,
          iconStyle: IconStyle(
            iconsColor: Colors.white,
            withBackground: true,
            backgroundColor: iconColor ?? Theme.of(context).dividerColor,
          ),
        );
}
