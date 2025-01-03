import 'package:flutter/material.dart';

class BottomNavigationProvider with ChangeNotifier {
  // this provider for manage navigation between bottom bar
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void navigateTo(BuildContext context, int index) {
    // if (index == _selectedIndex) return;
    _selectedIndex = index;
    notifyListeners();
    switch (index) {
      case 0: // home
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1: // search
        Navigator.pushNamed(context, '/search');
        break;
      case 2: // create recipe
        ModalRoute.of(context)?.settings.name == '/recipes/create-recipe'
            ? null
            : Navigator.pushReplacementNamed(context, '/recipes/create-recipe');
        break;
      case 3: // favourites
        Navigator.pushNamed(context, '/favourites');
        break;
      case 4: // profile
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }
}
