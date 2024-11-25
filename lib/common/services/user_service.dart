import 'package:got_food/main.dart';

class UserService {
  Future<dynamic> fetchUserDetails(String userId) async {
    // fetch user details
    try {
      return await supabase.from('profiles').select().eq('id', userId);
    } catch (e) {
      print('[User Service] Error fetching user details: $e');
    }
  }
}
