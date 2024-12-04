import 'package:flutter/material.dart';
import 'package:got_food/features/auth/auth_service.dart';

class ResetViewModel extends ChangeNotifier {
  final AuthService _authService;
  ResetViewModel(this._authService);

  late BuildContext ctx;
  set context(BuildContext context) => ctx = context;

  bool isLoading = false;

  Future<void> resetPassword({required String password}) async {
    isLoading = true;
    notifyListeners();
    try {
      final res = await _authService.resetPassword(password: password);
      await _authService.signOut();
      Navigator.of(ctx).pushReplacementNamed('/login');
    } catch (e) {
      print('[Reset View Model] Error Resetting Password: $e');
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text('Error Resetting Password: $e'),
          backgroundColor: Theme.of(ctx).colorScheme.error,
        ),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
