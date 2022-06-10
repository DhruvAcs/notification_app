import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notification_app/pages/admin%20pages/admin_home_page.dart';
import 'package:notification_app/pages/forgot_pw_page.dart';
import 'package:notification_app/pages/teacher_select_page.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:notification_app/main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final FirebaseAuth instance = FirebaseAuth.instance;
  late final User user;

  @override
  initState() {
    super.initState();
    user = instance.currentUser!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        title: Text(
          user.email!,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body:  SettingsList(
        darkTheme: const SettingsThemeData(settingsListBackground: Colors.white),
        lightTheme: const SettingsThemeData(settingsListBackground: Colors.white),
        sections: [
          SettingsSection(
            title: const Text('General',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),),
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
                value: const Text(' '),
                onPressed: (context) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TeacherSelectPage(),
                  ));
                }
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.web),
                title: const Text('School website'),
                value: const Text('School Name'),
                onPressed: (context)  {

                },

              ),

            ],
          ),
          SettingsSection(
            title: const Text('Account',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.search),
                title: const Text('Password'),
                value: const Text('*********'),
                onPressed: (context) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ForgotPasswordPage(),
                  ));
                },

              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.person),
                title: const Text('Switch to Admin'),
                value: const Text('This will only work with admin permission accounts'),
                onPressed: (context) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AdminHomePage(),
                  ));
                },
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