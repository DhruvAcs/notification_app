// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:notification_app/Auth/main_page.dart';
import 'pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: const FirebaseOptions(
      apiKey: "AIzaSyDRatQVo_t6wROVtCLcxkhgtPS27i3VePQ",
      appId: "1:546133077542:android:746b23fd482678c8fcc0e7",
      messagingSenderId: "546133077542",
      projectId: "schedula-cd37d",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            darkTheme: ThemeData.dark(),
            theme: ThemeData.light(),
            themeMode: currentMode,
            debugShowCheckedModeBanner: false,
            home: const MainPage(),
          );
        },
    );
  }
}
