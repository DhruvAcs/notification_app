import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/pages/admin%20pages/input_page.dart';
import 'package:notification_app/pages/dashboard_page.dart';

import 'account_page.dart';


class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

final user = FirebaseAuth.instance.currentUser!;

class _AdminHomePageState extends State<AdminHomePage> {
  late Widget _currentPage ;

  @override
  void initState() {
    _currentPage = const DashboardPage();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text('Admin'),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (index){
          switch (index){
            case 0:
              _currentPage = const DashboardPage();
              break;
            case 1:
              _currentPage = const InputPage();
              break;
            case 2:
              _currentPage = const AccountPage();
              break;
          }
          setState(() {

          });
        },
        backgroundColor: Colors.grey.shade50,
        color: Colors.deepPurpleAccent,
        animationDuration: const Duration(milliseconds: 450),
        items: const [
          Icon(Icons.dashboard, color: Colors.white,),
          Icon(Icons.edit, color:Colors.white),
          Icon(Icons.person_search, color:Colors.white),
        ],
      ),
      body: _currentPage,
    );
  }
}
