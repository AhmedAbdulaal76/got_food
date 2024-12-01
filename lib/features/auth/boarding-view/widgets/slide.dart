import 'package:flutter/material.dart';

// this is a widget that represents the layout of a single slide in the boarding view
class Slide extends StatelessWidget {
  const Slide(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.image});

  final String title;
  final String subtitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          height: 180,
          width: 180,
        ),
        const SizedBox(height: 32),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          textAlign: TextAlign.center,
          subtitle,
          style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
        ),
      ],
    );
  }
}
