import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/pages/settings_page.dart';
import 'package:notification_app/pages/teacherSelect_page.dart';
import 'dashboard_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final user = FirebaseAuth.instance.currentUser!;

class _HomePageState extends State<HomePage> {
  late Widget _currentPage ;

  @override
  void initState() {
    _currentPage = const DashboardPage();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (index){
          switch (index){
            case 0:
              _currentPage = const DashboardPage();
              break;
            case 1:
              _currentPage = const TeacherSelectPage();
              break;
            case 2:
              _currentPage = const SettingsPage();
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
          Icon(Icons.add, color:Colors.white),
          Icon(Icons.settings, color:Colors.white),
        ],
      ),
      body: _currentPage,
    );
  }
}
