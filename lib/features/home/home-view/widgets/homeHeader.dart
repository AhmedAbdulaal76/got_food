import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello, Username",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Featured Recipes",
                style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
        const CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(
              "https://mighty.tools/mockmind-api/content/human/5.jpg"),
        ),
      ],
    );
  }
}
