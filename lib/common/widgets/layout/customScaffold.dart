import 'package:flutter/material.dart';
import 'package:got_food/common/widgets/layout/bottom-navbar/customBottomNav.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.title,
    required this.body,
    this.showBottomNav = true,
    this.showAppBar = true,
    this.showBackButton = true,
    this.actionIcon,
    this.actionFunc,
  });

  final String title;
  final Widget body;
  final bool showBottomNav;
  final bool showAppBar;
  final bool showBackButton;
  final Widget? actionIcon;
  final Function()? actionFunc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: Text(title),
              automaticallyImplyLeading: showBackButton,
              actions: [
                IconButton(
                  onPressed: actionFunc,
                  icon: actionIcon ?? const SizedBox.shrink(),
                ),
              ],
            )
          : null,
      body: body,
      bottomNavigationBar: showBottomNav ? const CustomBottomNav() : null,
    );
  }
}
