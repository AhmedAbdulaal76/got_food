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

  Future<AuthResponse> signUp(
      {required String email,
      required String password,
      required String username}) async {
    try {
      final AuthResponse res = await supabase.auth.signUp(
          email: email, password: password, data: {'display_name': username});
      await _registerProfile(username);
      return res;
    } catch (e) {
      print('[Auth Service] Sign up error: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      print('[Auth Service] Sign out error: $e');
      rethrow;
    }
  }

  // Future<void> resetPassword({required String email}) async {
  //   try {
  //     await supabase.auth.resetPasswordForEmail(email);
  //   } catch (e) {
  //     print('[Auth Service] Reset password error: $e');
  //     rethrow;
  //   }
  // }

  // populate profiles table with user data
  Future<void> _registerProfile(String username) async {
    try {
      var userId = supabase.auth.currentUser?.id;
      final res = await supabase.from('profiles').insert([
        {'user_uuid': userId, 'username': username}
      ]);
      print('[Auth Service] Profile registered: $res');
    } catch (e) {
      print('[Auth Service] Profile registration error: $e');
      rethrow;
    }
  }
}
