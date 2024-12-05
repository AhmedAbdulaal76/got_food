import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:got_food/common/style/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileHeader extends StatelessWidget {
  ProfileHeader({super.key});

  final User? user = Supabase.instance.client.auth.currentUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 65,
          backgroundImage: NetworkImage(
              "https://mighty.tools/mockmind-api/content/human/5.jpg"
          ),
        ),
        SizedBox(height: 15),
        Text(
            'Chef',
            style: TextStyle(
                        height: 0.3,
                        color:Color.alphaBlend(Colors.black.withOpacity(0.3),
                        GotFoodTheme.kColorScheme.primary),
                        fontSize: 18, fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),),
        Text(
                " \t ${user?.userMetadata?['display_name']}",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 26,
                    color:Color.alphaBlend(Colors.black.withOpacity(0.3), GotFoodTheme.kColorScheme.primary)
                ),
              ),
        Text(
          " \t ${user?.userMetadata?['email']}",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 22,
              color:Color.alphaBlend(Colors.black.withOpacity(0.3), Colors.grey).withOpacity(0.95)
          ),
        ),
        SizedBox(height: 12),
        Container(
          alignment: Alignment.center,
          width: 200,
            height: 40,
            child:
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child:  Text('Edit Profile',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontSize: 18,
                                fontWeight: FontWeight.bold,

                                  ),

            )
            ),
        )
      ]);
  }
}