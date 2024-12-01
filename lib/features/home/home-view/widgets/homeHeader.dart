import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeHeader extends StatelessWidget {
  HomeHeader({super.key});

  final User? user = Supabase.instance.client.auth.currentUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, ${user?.userMetadata?['display_name'] ?? 'Guest'}",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
              const SizedBox(height: 8),
              Text("Featured Recipes",
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
        ),
        const SizedBox(width: 8),
        const CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(
              "https://mighty.tools/mockmind-api/content/human/5.jpg"),
        ),
      ],
    );
  }
}
