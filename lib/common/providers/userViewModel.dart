import 'package:flutter/material.dart';
import 'package:got_food/common/models/user.dart' as appUser;
import 'package:got_food/common/services/user_service.dart';
import 'package:got_food/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserViewModel extends ChangeNotifier {
  final UserService _userService;
  UserViewModel(this._userService);

  final User? _user = supabase.auth.currentUser;
  // User? get user => _user;
  appUser.User? _appUser;

  appUser.User? get user => _appUser;

  Future<void> fetchUserDetails() async {
    // fetch user details
    if (_user != null) {
      try {
        Map<String, dynamic> res =
            await _userService.fetchUserDetails(_user.id);
        _appUser = appUser.User.fromJson(res);
        print('[User View Model] User: $_appUser');
        notifyListeners();
      } catch (e) {
        print('[User View Model] Error fetching user details: $e');
      }
    } else {
      print('[User View Model] User is null');
    }
  }

  // void setUser(User user) {
  //   _user = user;
  //   notifyListeners();
  // }
}
