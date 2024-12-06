import 'package:flutter/material.dart';
import 'package:got_food/common/providers/themeProvider.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/features/account/settings-view/widgets/CustomSettingsGroup.dart';
import 'package:got_food/features/account/settings-view/widgets/CustomSettingsItem.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  String _selectedLanguage = 'English';
  String _selectedTheme = 'System';

  final User? user = Supabase.instance.client.auth.currentUser;

  void _setTheme(String theme) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    setState(() {
      _selectedTheme = theme;

      ThemeMode themeMode = theme == 'Light'
          ? ThemeMode.light
          : theme == 'Dark'
              ? ThemeMode.dark
              : ThemeMode.system;

      themeProvider.setThemeMode(themeMode);
    });
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

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Settings",
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              // Language Setting
              CustomSettingsGroup(
                items: [
                  CustomSettingsItem(
                    title: "Language",
                    subtitle: _selectedLanguage,
                    icon: Icons.language,
                    trailing: DropdownButton<String>(
                      value: _selectedLanguage,
                      items: <String>['English'].map((String language) {
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
                    context: context,
                  ),
                ],
              ),
              // Theme Setting
              CustomSettingsGroup(
                items: [
                  CustomSettingsItem(
                    title: 'Theme',
                    subtitle: _selectedTheme,
                    icon: _selectedTheme == 'Dark'
                        ? Icons.dark_mode_rounded
                        : _selectedTheme == 'Light'
                            ? Icons.light_mode_rounded
                            : Icons.brightness_auto_rounded,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Consumer<ThemeProvider>(
                            builder: (context, themeProvider, child) {
                              _selectedTheme = themeProvider.themeMode ==
                                      ThemeMode.light
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
                    context: context,
                  ),
                ],
              ),
              // Change Name
              CustomSettingsGroup(
                items: [
                  CustomSettingsItem(
                    title: "Edit Profile",
                    subtitle: user?.userMetadata?['display_name'],
                    icon: Icons.edit,
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );
                    },
                    context: context,
                  ),
                ],
              ),
              // Sign Out
              CustomSettingsGroup(
                items: [
                  CustomSettingsItem(
                    title: "Sign Out",
                    icon: Icons.exit_to_app_rounded,
                    onTap: () {
                      _showConfirmationDialog(
                        "Sign Out",
                        () async {
                          await supabase.auth.signOut();
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (route) => false);
                        },
                      );
                    },
                    context: context,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
