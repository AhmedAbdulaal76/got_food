import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:provider/provider.dart';
import 'package:got_food/common/providers/themeProvider.dart'; // Import ThemeProvider

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:got_food/common/style/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../main.dart';



void main() {
  runApp( MaterialApp(home: SettingsPage()));
}


class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);





  @override
  _SettingsState createState() => _SettingsState();
}



class _SettingsState extends State<SettingsPage> {
  String _selectedLanguage = 'English';
  String _userName = 'User';
  String _selectedTheme = 'System';
  User? _user;

  @override
  void initState() {
    super.initState();
    // Initialize the user
    _user = Supabase.instance.client.auth.currentUser;
  }

  void _setTheme(String theme) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    setState(() {
      _selectedTheme = theme;

      // Set theme mode based on the selected option
      ThemeMode themeMode;
      if (theme == 'Light') {
        themeMode = ThemeMode.light;
      } else if (theme == 'Dark') {
        themeMode = ThemeMode.dark;
      } else {
        themeMode = ThemeMode.system;  // For System Default
      }

      // Update the global theme mode via ThemeProvider
      themeProvider.setThemeMode(themeMode);
    });
  }



  void _showChangeNameDialog() {
    TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Change Name"),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: "Enter new name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _userName = nameController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _showConfirmationDialog(String title, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Are you sure?"),
          content: const Text("This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              child: Text(title),
            ),
          ],
        );
      },
    );
  }

  SettingsItem _buildSettingsItem({
    required String title,
    String? subtitle,
    required IconData icon,
    VoidCallback? onTap,
    Widget? trailing,
    Color iconColor = Colors.blue,
  }) {
    return SettingsItem(
      onTap: onTap,
      icons: icon,
      title: title,
      subtitle: subtitle,
      iconStyle: IconStyle(
        iconsColor: Colors.white,
        withBackground: true,
        backgroundColor: iconColor,
      ),
      trailing: trailing,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the current theme
    final theme = Theme.of(context);

    return CustomScaffold(
      title: "Settings",
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              // Language
              SettingsGroup(
                backgroundColor: Theme.of(context).highlightColor,
                margin: const EdgeInsets.all(10),
                items: [
                  _buildSettingsItem(
                    title: "Language",
                    subtitle: _selectedLanguage,
                    icon: Icons.language,
                    iconColor: Theme.of(context).dividerColor,
                    trailing: DropdownButton<String>(
                      value: _selectedLanguage,
                      items:
                      <String>['English'].map((String language) {
                        return DropdownMenuItem<String>(
                          value: language,
                          child: Text(language),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedLanguage = newValue ?? 'English';
                        });
                      },
                    ),
                  ),
                ],
              ),
              // Theme
              SettingsGroup(
                backgroundColor: Theme.of(context).highlightColor,
                margin: const EdgeInsets.all(10),
                items: [
                  _buildSettingsItem(
                    title: 'Theme',
                    subtitle: _selectedTheme,
                    icon: _selectedTheme == 'Dark'
                        ? Icons.dark_mode_rounded
                        : _selectedTheme == 'Light'
                        ? Icons.light_mode_rounded
                        : Icons.brightness_auto_rounded,
                    iconColor: Theme.of(context).dividerColor,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Consumer<ThemeProvider>(
                            builder: (context, themeProvider, child) {

                              _selectedTheme = themeProvider.themeMode == ThemeMode.light
                                  ? 'Light'
                                  : themeProvider.themeMode == ThemeMode.dark
                                  ? 'Dark'
                                  : 'System Default';

                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RadioListTile<String>(
                                    title: const Text('System Default'),
                                    value: 'System Default',
                                    groupValue: _selectedTheme,
                                    onChanged: (value) {
                                      _setTheme(value!);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  RadioListTile<String>(
                                    title: const Text('Light'),
                                    value: 'Light',
                                    groupValue: _selectedTheme,
                                    onChanged: (value) {
                                      _setTheme(value!);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  RadioListTile<String>(
                                    title: const Text('Dark'),
                                    value: 'Dark',
                                    groupValue: _selectedTheme,
                                    onChanged: (value) {
                                      _setTheme(value!);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              // Change Name
              SettingsGroup(
                backgroundColor: Theme.of(context).highlightColor,
                margin: const EdgeInsets.all(10),
                items: [
                  _buildSettingsItem(
                    title: "Edit Profile",
                    icon: Icons.edit,
                    iconColor: Theme.of(context).dividerColor,
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                            (route) => false,
                      );
                    },
                  ),
                ],
              ),
              // Sign Out
              SettingsGroup(
                backgroundColor: Theme.of(context).highlightColor,
                margin: const EdgeInsets.all(10),
                items: [
                  _buildSettingsItem(
                    title: "Sign Out",
                    icon: Icons.exit_to_app_rounded,
                    iconColor: Theme.of(context).dividerColor,
                    onTap: () {
                      _showConfirmationDialog("Sign Out", ()  async {
                        await supabase.auth.signOut();
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      },);


                    },
                  ),
                ],
              ),
        // SettingsGroup(
        //   backgroundColor: Theme.of(context).highlightColor,
        //   margin: const EdgeInsets.all(10),
        //   items: [
        //     _buildSettingsItem(
        //       title: "Delete Account",
        //       icon: CupertinoIcons.delete_solid,
        //       iconColor: Theme.of(context).dividerColor,
        //       onTap: () {
        //         _showConfirmationDialog("Delete Account", () async {
        //           if (_user != null) {
        //             try {
        //
        //               await supabase.auth.signOut();
        //               ///
        //               await supabase.from('profiles').delete().eq('user_uuid', _user!.id);
        //               await supabase.auth.admin.deleteUser(_user!.id);
        //               ///
        //               Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        //             }
        //             catch (e) {
        //               print("Error deleting account: $e");
        //               ScaffoldMessenger.of(context).showSnackBar(
        //                 SnackBar(
        //                   content: Text("Error deleting account: $e"),
        //                 ),
        //               );
        //             }
        //           } else {
        //             // Handle case where user is null
        //             print("User is not signed in");
        //             ScaffoldMessenger.of(context).showSnackBar(
        //               const SnackBar(
        //                 content: Text("No user is signed in."),
        //               ),
        //             );
        //           }
        //         });
        //       },
        //     ),
        //   ],
        // ),
        ],
          ),
        ),
      ),
      showBottomNav: true,
      showBackButton: true,

    );
  }
}

