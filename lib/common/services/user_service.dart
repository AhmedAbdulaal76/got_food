import 'package:got_food/main.dart';

class UserService {
  Future<dynamic> fetchUserDetails(String userId) async {
    // fetch user details
    try {
      final res =
          await supabase.from('profiles').select().eq('user_uuid', userId);
      print('[User Service] User details fetched: $res');
      return res;
    } catch (e) {
      print('[User Service] Error fetching user details: $e');
    }
  }
}
