import 'package:flutter/material.dart';

class TabItems extends StatelessWidget {
  const TabItems(
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
                color: Theme.of(context).brightness == Brightness.dark
                    ? selectedIndex == index
                        ? Theme.of(context).colorScheme.surface
                        : Theme.of(context).colorScheme.primary
                    : selectedIndex == index // for light theme
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  list[index],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight:
                            selectedIndex == index ? FontWeight.bold : null,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? selectedIndex == index
                                ? Theme.of(context).colorScheme.onSurface
                                : Theme.of(context).colorScheme.onPrimary
                            : selectedIndex == index // for light theme
                                ? Colors.white
                                : Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
