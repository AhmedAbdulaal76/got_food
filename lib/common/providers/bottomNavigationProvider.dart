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
    if (index == _selectedIndex) return;
    _selectedIndex = index;
    notifyListeners();
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
    }
  }
}