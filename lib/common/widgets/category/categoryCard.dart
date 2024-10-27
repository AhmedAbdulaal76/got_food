import 'package:flutter/material.dart';
import 'package:got_food/common/style/themes/themeColors.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({
    super.key,
    required this.name,
    this.isSelected = false,
  });

  final String name;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(end: 8),
      height: 41,
      width: 124,
      decoration: BoxDecoration(
        color: isSelected
            ? ThemeColors.primaryColorDark
            : ThemeColors.primaryColorLight,
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextButton(
        onPressed: () {},
        child: Text(
          name,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isSelected ? Colors.white : ThemeColors.primaryColorDark),
        ),
      ),
    );
  }
}
