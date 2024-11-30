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
      case 0:
        ModalRoute.of(context)?.settings.name == '/home'
            ? null
            : Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        break;
      case 2:
        ModalRoute.of(context)?.settings.name == '/recipes/create-recipe'
            ? null
            : Navigator.pushReplacementNamed(context, '/recipes/create-recipe');
        break;
      case 3:
        break;
      case 4:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }
}
