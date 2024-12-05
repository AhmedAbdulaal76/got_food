import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/common/services/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  runApp( const MaterialApp(home: EditProfilePage()));
}


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  File? _selectedImage;
  final UserService _userService = UserService();
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _fetchAndPopulateUserDetails() async {
    setState(() {
      _isLoading = true;
    });

    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No user is signed in.')),
      );
      return;
    }

    final userDetails = await _userService.fetchUserDetails(user.id);

    if (userDetails != null && userDetails.isNotEmpty) {
      final userData = userDetails[0];
      _nameController.text = userData['name'] ?? '';
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _updateProfile() async {
    if (_nameController.text.isNotEmpty) {
      try {
        final user = Supabase.instance.client.auth.currentUser;
        await Supabase.instance.client
            .from('profiles')
            .update({'username': _nameController.text})
            .eq('user_uuid', user!.id);

        // Update the user metadata locally
        user.userMetadata!['display_name'] = _nameController.text;

        // Save the updated metadata back to Supabase
        await Supabase.instance.client.auth.updateUser(
          UserAttributes(data: user.userMetadata!),
        );

        // Reset inputs and navigate back
        _nameController.clear();
        Navigator.pop(context, 'updated');
      } catch (e) {
        print('Error updating profile: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')),
        );
      }
    }
  }





  @override
  void initState() {
    super.initState();
    _fetchAndPopulateUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Edit Profile',
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Updated Name'),
              ),
              const SizedBox(height: 10),
              if (_selectedImage != null)
                Image.file(
                  _selectedImage!,
                  height: 150,
                ),
              TextButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text('Pick Image'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Call the profile update function
                    await _updateProfile();

                    // Clear the inputs
                    _nameController.clear();

                    // Navigate back to the profile page
                    Navigator.pushNamedAndRemoveUntil(context, '/profile', (route) => false);
                  } catch (e) {
                    print("Error updating profile: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Failed to update profile: $e")),
                    );
                  }
                },
                child: const Text('Update Profile'),
              ),

            ],
          ),
        ),
      ),
      showBottomNav: true,
      showBackButton: true,
    );
  }
}
