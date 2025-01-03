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

  Future<void> updateUserDetails(String userId, String name, String? imageUrl) async {
    // Update user details
    try {
      final data = {
        'username': name,
        if (imageUrl != null) 'imageurl': imageUrl,
      };

      final res = await supabase.from('profiles').update(data).eq('user_uuid', userId);
      print('[User Service] User details updated: $res');
    } catch (e) {
      print('[User Service] Error updating user details: $e');
      throw Exception('Failed to update user details: $e');
    }
  }
}
