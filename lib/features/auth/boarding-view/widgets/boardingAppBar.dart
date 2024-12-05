import 'package:flutter/material.dart';

class BoardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BoardingAppBar({
    super.key,
    required this.current,
    required this.slides,
  });

  final int current;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Colors.white,
      actions: [
        if (current != slides.length - 1)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/home");
              },
              child: const Text(
                'later',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
