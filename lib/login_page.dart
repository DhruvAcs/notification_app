import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.access_alarm_rounded,
                size: 150,
              ),
              SizedBox(height:60),
              Text(
                'Welcome To the APP',
                style: GoogleFonts.bebasNeue(fontWeight: FontWeight.bold, fontSize: 52),
              ),
              SizedBox(height: 10),
              Text(
                'Plan your schedule on time!',
                style: GoogleFonts.bebasNeue(fontSize: 20),
              ),
              SizedBox(height: 40),

              //email box
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: '  Email')),
                ),
              ),
              SizedBox(height: 10),

              //password box
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: '  Password')),
                ),
              ),
              SizedBox(height: 10),

              //Sign in button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 135.0),
                child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.lightBlueAccent[100],
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text('Sign In',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    )),
              ),
              SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ' Register now',
                    style: TextStyle(
                        color: Colors.lightBlue[400],
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
