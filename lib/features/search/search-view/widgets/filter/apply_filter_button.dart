import 'package:flutter/material.dart';

class ApplyFilterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ApplyFilterButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text(
          'Apply Filter',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
