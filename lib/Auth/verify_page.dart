import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:notification_app/pages/home_page.dart';


class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final instance = FirebaseAuth.instance;
  late User user;
  late Timer timer;
  // final _firstNameController = TextEditingController();
  // final _lastNameController = TextEditingController();

  @override
  void initState() {
    user = instance.currentUser!;
    user.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  Future<void> checkEmailVerified() async {
    user = instance.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[400],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.network(
                  'https://assets9.lottiefiles.com/packages/lf20_kdccichi.json',
                  width: 150,
                  height: 75,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 10),
                Text(
                  'An email has been sent to ${user.email} please verify',
                  style: GoogleFonts.bebasNeue(
                      fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(height: 10),
                Text(
                  'Please wait up to 2 minutes for the email, if you do not see the email please check your spam',
                  style: GoogleFonts.bebasNeue(fontSize: 20),
                ),
                const SizedBox(height: 40),
                Lottie.network(
                  'https://assets10.lottiefiles.com/packages/lf20_rqilnf3p.json',
                  width: 250,
                  height: 250,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
        ),
      ),

      // body: Center(
      //   child: Text(
      //       'An email has been sent to ${user.email} please verify'),
      // ),
    );
  }


}