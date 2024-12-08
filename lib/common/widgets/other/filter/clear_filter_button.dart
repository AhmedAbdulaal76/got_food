import 'package:flutter/material.dart';

class ClearFilterButton extends StatelessWidget {
  final VoidCallback onTap;

  const ClearFilterButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: const Text(
          'Clear Filter',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
