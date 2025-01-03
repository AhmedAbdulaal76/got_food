import 'package:flutter/material.dart';
import 'package:got_food/common/providers/bottomNavigationProvider.dart';
import 'package:provider/provider.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavigationProvider bottomNavigationProvider =
        Provider.of<BottomNavigationProvider>(context);
    // final LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context);
    // bool loginFlag = loginViewModel.loginFlag;
    return BottomNavigationBar(
      currentIndex: bottomNavigationProvider.selectedIndex,
      onTap: (index) {
        bottomNavigationProvider.navigateTo(context, index);
      },
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        // + icon to create a new recipe
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Create',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
