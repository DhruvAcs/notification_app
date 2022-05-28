import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:notification_app/main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  late final instance;
  late final user;
  initState() {
    instance = FirebaseAuth.instance;
    user = instance.currentUser!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SettingsList(
        darkTheme: const SettingsThemeData(settingsListBackground: Colors.white),
        lightTheme: const SettingsThemeData(settingsListBackground: Colors.white),
        sections: [
          SettingsSection(
            title: const Text('General'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                value: const Text('English'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {
                  log(value.toString());
                  log(MyApp.themeNotifier.value.toString());

                  if (value) {
                    return MyApp.themeNotifier.value = ThemeMode.dark;
                  }
                  MyApp.themeNotifier.value = ThemeMode.light;
                  setState(() {
                  });
                },
                initialValue: MyApp.themeNotifier.value == ThemeMode.light ? false : true,
                leading: const Icon(Icons.dark_mode),
                title: const Text('Dark Mode'),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.person),
                title: const Text('Teacher select'),
                value: const Text('English'),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.web),
                title: const Text('School website'),
                value: const Text('School Name'),
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Account'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.search),
                title: const Text('Password'),
                value: const Text('*********'),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.search),
                title: const Text('Logout'),
                value: const Text('Bye Bye'),
                onPressed: (context) {
                  instance.signOut();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}