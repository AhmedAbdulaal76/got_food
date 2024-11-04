import 'package:flutter/material.dart';
import 'package:got_food/common/models/category.dart';
import 'package:got_food/common/style/themes/themeColors.dart';

class CategoryCard extends StatelessWidget {
  final bool isSelected;
  final Category category;

  const CategoryCard({
    super.key,
    this.isSelected = false,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Check if there's enough space to show the image
        bool showImage =
            constraints.maxHeight > 80 && constraints.maxWidth > 150;

        return Container(
          height: showImage ? 140 : 41,
          width: showImage ? 220 : 124,
          decoration: BoxDecoration(
            color: isSelected
                ? ThemeColors.primaryColorDark
                : ThemeColors.primaryColorLight,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Conditionally show the image if there's enough space
                if (showImage)
                  Container(
                    height: constraints.maxHeight *
                        0.4, // Image height based on available space
                    width: constraints.maxWidth * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(category.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                // Display category name
                Text(
                  category.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? Colors.white
                          : ThemeColors.primaryColorDark),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
