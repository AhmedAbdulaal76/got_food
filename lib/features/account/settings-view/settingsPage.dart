import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:got_food/common/style/themes/themeColors.dart';
import 'package:flutter/material.dart';
import 'package:got_food/common/providers/bottomNavigationProvider.dart';
import 'package:provider/provider.dart';
import 'package:got_food/common/widgets/layout/bottom-navbar/customBottomNav.dart';


void main() {
  runApp(MaterialApp(home: Settings()));
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _selectedLanguage = 'English';
  bool _isDarkMode = false;
  String _userName = 'User';

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

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              SettingsGroup(
                backgroundColor: theme.highlightColor,
                margin: const EdgeInsets.all(10),
                items: [
                  _buildSettingsItem(
                    title: "Language",
                    subtitle: _selectedLanguage,
                    icon: Icons.language,
                    iconColor: theme.dividerColor,
                    trailing: DropdownButton<String>(
                      value: _selectedLanguage,
                      items:
                          <String>['English', 'Arabic'].map((String language) {
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
              SettingsGroup(
                backgroundColor: theme.highlightColor,
                margin: const EdgeInsets.all(10),
                items: [
                  _buildSettingsItem(
                    title: 'Theme',
                    subtitle: _isDarkMode ? "Dark" : "Light",
                    iconColor: theme.dividerColor,
                    icon: _isDarkMode
                        ? Icons.dark_mode_rounded
                        : Icons.light_mode_rounded,
                    trailing: Switch.adaptive(
                      value: _isDarkMode,
                      onChanged: (value) {
                        setState(() {
                          _isDarkMode = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SettingsGroup(
                backgroundColor: theme.highlightColor,
                margin: const EdgeInsets.all(10),
                items: [
                  _buildSettingsItem(
                    title: "Change Name",
                    subtitle: _userName,
                    icon: Icons.edit,
                    iconColor: theme.dividerColor,
                    onTap: _showChangeNameDialog,
                  ),
                ],
              ),
              SettingsGroup(
                backgroundColor: theme.highlightColor,
                margin: const EdgeInsets.all(10),
                items: [
                  _buildSettingsItem(
                    title: "Sign Out",
                    icon: Icons.exit_to_app_rounded,
                    iconColor: theme.dividerColor,
                    onTap: () {
                      _showConfirmationDialog("Sign Out", () {
                        print("User signed out");
                      });
                    },
                  ),
                ],
              ),
              SettingsGroup(
                backgroundColor: theme.highlightColor,
                margin: const EdgeInsets.all(10),
                items: [
                  _buildSettingsItem(
                    title: "Delete Account",
                    icon: CupertinoIcons.delete_solid,
                    iconColor: theme.dividerColor,
                    onTap: () {
                      _showConfirmationDialog("Delete Account", () {
                        print("Account deleted");
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
     // bottomNavigationBar:  CustomBottomNav(),  // Add the custom bottom navigation bar here
    );
  }
}
