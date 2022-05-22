import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final user = FirebaseAuth.instance.currentUser!;
final List<Widget> _pages = [

];

class _HomePageState extends State<HomePage> {
  late Widget _currentPage ;
  Widget dashboard(){
    return Container();
  }
  Widget calender(){
    return Container();
  }
  Widget settings(){
    return Center(
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
        ));
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
