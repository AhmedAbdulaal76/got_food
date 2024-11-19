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
  });

  final String title;
  final Widget body;
  final bool showBottomNav;
  final bool showAppBar;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: body,
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}
