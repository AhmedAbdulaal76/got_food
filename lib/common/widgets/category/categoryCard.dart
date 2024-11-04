import 'package:flutter/material.dart';
import 'package:got_food/common/models/category.dart';
import 'package:got_food/common/style/themes/themeColors.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({
    super.key,
    this.isSelected = false,
    required this.category,
  });

  bool isSelected;
  Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41,
      width: 124,
      decoration: BoxDecoration(
        color: isSelected
            ? ThemeColors.primaryColorDark
            : ThemeColors.primaryColorLight,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Text(
          category.name,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isSelected ? Colors.white : ThemeColors.primaryColorDark),
        ),
      ),
    );
  }
}
