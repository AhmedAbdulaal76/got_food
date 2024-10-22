import 'package:flutter/material.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Home Page",
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Go to Second Page'),
        ),
      ),
    );
  }
}
