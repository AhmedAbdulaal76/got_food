import 'package:flutter/material.dart';
import 'package:got_food/common/style/themes/themeColors.dart';

class TabItem extends StatelessWidget {
  const TabItem(
      {super.key,
      required this.onTabSelected,
      this.selectedIndex = 0,
      required this.list,
      required this.viewModel});

  final int selectedIndex;
  final void Function(ChangeNotifier, int) onTabSelected;
  final List<dynamic> list;
  final ChangeNotifier viewModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 41,
      child: ListView.builder(
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onTabSelected(viewModel, index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300), // Animation duration
              curve: Curves.easeInOut, // Animation curve
              height: 41,
              width: 124,
              margin: const EdgeInsetsDirectional.only(end: 8),
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? ThemeColors.primaryColorDark
                    : ThemeColors.primaryColorLight,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  list[index],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color:
                          selectedIndex == index ? Colors.white : Colors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
