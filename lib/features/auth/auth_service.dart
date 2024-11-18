import 'package:got_food/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  Future<AuthResponse> signInWithPassword(
      {required String email, required String password}) async {
    try {
      final AuthResponse res = await supabase.auth
          .signInWithPassword(email: email, password: password);
      return res;
    } catch (e) {
      print('[Auth Service] Sign in with password error: $e');
      rethrow;
    }
  }

   Future<AuthResponse>  signUp(
      {required String email,
      required String password,
      required String username}) async {
    try {
      final AuthResponse res = await supabase.auth.signUp(
          email: email, password: password, data: {'display_name': username});
      return res;
    } catch (e) {
      print('[Auth Service] Sign up error: $e');
      rethrow;
    }
  }
}
