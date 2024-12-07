import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../common/providers/userViewModel.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  final TextEditingController _nameController = TextEditingController();
  File? _selectedImage;
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

    try {
      // Fetch user details directly from Supabase
      final response = await Supabase.instance.client
          .from('profiles')
          .select()
          .eq('user_uuid', user.id)
          .single();  // Get a single record

      // Populate the name controller with the user's name
      _nameController.text = response['name'] ?? '';
      // Optionally, populate other fields like imageUrl if available
      _selectedImage = response['imageurl'] ?? '';
        } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user details: $e')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _updateProfile() async {
    if (_nameController.text.isNotEmpty) {
      try {
        final user = Supabase.instance.client.auth.currentUser;
        await Supabase.instance.client.from('profiles').update(
            {'username': _nameController.text}).eq('user_uuid', user!.id);

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

    if (_selectedImage != null) {
      try {
        final user = Supabase.instance.client.auth.currentUser;
        DateTime now = DateTime.now();
        // Upload the image to Supabase storage
        final filePath = 'profile-images-${user?.id}_$now.jpg'; // Unique file path
        await Supabase.instance.client.storage
            .from('profiles') // Assuming 'profiles' is the storage bucket
            .upload(filePath, _selectedImage!);

        // Get the public URL of the uploaded image
        final imageUrl = Supabase.instance.client.storage
            .from('profiles')
            .getPublicUrl(filePath);

        // Update the profile image URL in the database
        await Supabase.instance.client.from('profiles').update(
          {'imageurl': imageUrl},
        ).eq('user_uuid', user!.id);

        print('Image uploaded and profile updated successfully');
      } catch (e) {
        print('Error updating profile image: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile image: $e')),
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
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _pickImage,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _selectedImage != null
                        ? CircleAvatar(
                      radius: 90,
                      backgroundImage: FileImage(_selectedImage!),
                    )
                        : CircleAvatar(
                      radius: 90,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5),
                      child: const Icon(Icons.account_circle, size: 50),
                    ),
                    const SizedBox(height: 8), // Space between the avatar and the text
                    const Text('Tap to Edit',),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _nameController,
                decoration:
                const InputDecoration(labelText: 'Updated Name'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Call the profile update function
                    await _updateProfile();
                    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
                    userViewModel.fetchUserDetails();

                    // Clear the inputs
                    _nameController.clear();

                    // Navigate back to the profile page
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/profile', (route) => false);
                  } catch (e) {
                    print("Error updating profile: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("Failed to update profile: $e")),
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