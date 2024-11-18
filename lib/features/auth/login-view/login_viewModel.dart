import 'package:flutter/material.dart';
import '../auth_service.dart';

class LoginViewModel with ChangeNotifier {
  final AuthService _authService;

  LoginViewModel(this._authService);
  // this provider for manage navigation between bottom bar
  bool _loginFlag = false;
  bool get loginFlag => _loginFlag;

  void toggleLoginFlag(){
    _loginFlag = !_loginFlag;
    notifyListeners();
  }

}
