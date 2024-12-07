import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:got_food/common/models/user.dart';
import 'package:got_food/common/providers/userViewModel.dart';
import 'package:got_food/common/style/theme.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  // final User? user = Supabase.instance.client.auth.currentUser;

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserViewModel>(context).user;
    return Column(children: [
      ClipOval(
        child: CircleAvatar(
          radius: 65,
          child: CachedNetworkImage(
            imageUrl: user != null ? user.imageUrl : '',
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
      const SizedBox(height: 15),
      Text(
        'Chef',
        style: TextStyle(
            height: 0.3,
            color: Color.alphaBlend(Colors.black.withOpacity(0.3),
                GotFoodTheme.kColorScheme.primary),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic),
      ),
      const SizedBox(height: 10),
      Text(
        " \t ${user != null ? user.username : 'Guest'}",
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
            fontSize: 26,
            color: Color.alphaBlend(Colors.black.withOpacity(0.3),
                GotFoodTheme.kColorScheme.primary)),
      ),
      // Text(
      //   " \t ${user.userMetadata?['email']}",
      //   style: Theme.of(context).textTheme.headlineMedium?.copyWith(
      //       fontWeight: FontWeight.bold,
      //       fontStyle: FontStyle.italic,
      //       fontSize: 22,
      //       color: Color.alphaBlend(Colors.black.withOpacity(0.3), Colors.grey)
      //           .withOpacity(0.95)),
      // ),
      const SizedBox(height: 12),
      Container(
        alignment: Alignment.center,
        width: 200,
        height: 40,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Text(
              'Edit Profile',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
            )),
      )
    ]);
  }
}
