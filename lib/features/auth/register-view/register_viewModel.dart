import 'package:flutter/material.dart';
import 'package:got_food/features/auth/auth_service.dart';

class RegisterViewModel extends ChangeNotifier {
  // Add your view model logic here
  final AuthService _authService;
  RegisterViewModel(this._authService);

  late BuildContext ctx;
  set context(BuildContext context) => ctx = context;

  bool isLoading = false;
  Future<void> signUp(
      {required String email,
      required String password,
      required String username}) async {
    isLoading = true;
    notifyListeners();
    try {
      final res = await _authService.signUp(
          email: email, password: password, username: username);
      Navigator.of(ctx).pushReplacementNamed('/home');
    } catch (e) {
      print('[Register View Model] Error signing up: $e');
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text('Error Registering: $e'),
          backgroundColor: Theme.of(ctx).colorScheme.error,
        ),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
