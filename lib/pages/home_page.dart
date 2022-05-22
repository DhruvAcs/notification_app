import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/pages/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final user = FirebaseAuth.instance.currentUser!;

class _HomePageState extends State<HomePage> {
  late Widget _currentPage ;
  Widget dashboard(){
    return Container();
  }
  Widget calender(){
    return Container();
  }
  Widget settings(){
    return SettingsPage();
  }
  @override
  void initState() {
    _currentPage = dashboard();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (index){
          switch (index){
            case 0:
              _currentPage = dashboard();
              break;
            case 1:
              _currentPage = calender();
              break;
            case 2:
              _currentPage = settings();
              break;
          }
          setState(() {

          });
        },
        backgroundColor: Colors.grey.shade50,
        color: Colors.lightBlue.shade200,
        animationDuration: const Duration(milliseconds: 450),
        items: const [
          Icon(Icons.home, color: Colors.white,),
          Icon(Icons.person, color:Colors.white),
          Icon(Icons.settings, color:Colors.white),
        ],
      ),
      body: _currentPage,
    );
  }
}
