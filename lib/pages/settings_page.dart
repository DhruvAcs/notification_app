import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final user =FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Signed in test as user : ' + user.email!),
            Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              clipBehavior: Clip.antiAlias,
              child: MaterialButton(
                minWidth: 125,
                height: 50,
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                color: Colors.lightBlue[100],
                child: const Text(
                  'Sign Out',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
