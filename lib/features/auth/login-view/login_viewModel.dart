import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../auth_service.dart';

class LoginViewModel with ChangeNotifier {
  final AuthService _authService;

  LoginViewModel(this._authService);

  late BuildContext ctx;
  set context(BuildContext context) => ctx = context;
  // this provider for manage navigation between bottom bar
  bool _loginFlag = false;
  bool get loginFlag => _loginFlag;

  void toggleLoginFlag() {
    _loginFlag = !_loginFlag;
    // notifyListeners();
  }

  User? _user;
  User? get user => _user;
  bool isLoading = false;

  Future<void> signInWithPaswsword(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      final res = await _authService.signInWithPassword(
          email: email, password: password);
      _user = res.user;
      _user != null ? _loginFlag = true : _loginFlag = false;
      Navigator.of(ctx).pushReplacementNamed('/home');
      print("[Login View Model] Successful login, User: $_user");
    } catch (e) {
      print('[Login View Model] Error logging in: $e');
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text('Error logging in: $e'),
          backgroundColor: Theme.of(ctx).colorScheme.error,
        ),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signInWithOtp(
      {required String email, required String otp}) async {
    isLoading = true;
    notifyListeners();

    try {
      final res = await _authService.signInWithOtp(email: email, otp: otp);
      _user = res.user;
      _user != null ? _loginFlag = true : _loginFlag = false;
      print("[Login View Model] Successful login, User: $_user");
      if (_user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('[Login View Model] Error logging in: $e');
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text('Error logging in: $e'),
          backgroundColor: Theme.of(ctx).colorScheme.error,
        ),
      );
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
