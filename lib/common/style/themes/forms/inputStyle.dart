import 'package:flutter/material.dart';
import 'package:got_food/common/style/themes/themeColors.dart';

class InputStyle {
  static OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: color,
        width: 1,
      ),
    );
  }

  static InputDecorationTheme get inputStyle {
    return InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintStyle: const TextStyle(
        color: ThemeColors.secondaryTextColor,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      filled: true,
      fillColor: Colors.white,
      errorMaxLines: 3,
      enabledBorder: _buildBorder(Colors.grey),
      focusedBorder: _buildBorder(ThemeColors.primaryColor),
      errorBorder: _buildBorder(Colors.red),
      focusedErrorBorder: _buildBorder(Colors.red),
    );
  }

  static InputDecorationTheme get darkInputStyle {
    return InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintStyle: TextStyle(
        color: ThemeColors.secondaryTextColorDark.withOpacity(0.7),
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      floatingLabelStyle: const TextStyle(
        color: ThemeColors.secondaryTextColorDark,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      filled: true,
      fillColor: ThemeColors.secondaryColor.withOpacity(0.5),
      errorMaxLines: 3,
      enabledBorder: _buildBorder(ThemeColors.primaryColor),
      focusedBorder: _buildBorder(ThemeColors.secondaryColorDark),
      errorBorder: _buildBorder(Colors.red),
      focusedErrorBorder: _buildBorder(Colors.red),
    );
  }
}
