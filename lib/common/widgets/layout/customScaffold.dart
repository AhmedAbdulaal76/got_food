import 'package:flutter/material.dart';
import 'package:got_food/common/widgets/layout/bottom-navbar/customBottomNav.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.title,
    required this.body,
  });

  final String title;
  final Widget body;

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
