import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final user = FirebaseAuth.instance.currentUser!;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.grey.shade50,
        color: Colors.lightBlue.shade200,
        animationDuration: Duration(milliseconds: 450),
        items: [
          Icon(Icons.home, color: Colors.white,),
          Icon(Icons.person, color:Colors.white),
          Icon(Icons.settings, color:Colors.white),
        ],
      ),
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
              child: Text(
                'Sign Out',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
