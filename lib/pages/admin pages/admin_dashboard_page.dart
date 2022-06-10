import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notification_app/read%20data/get_action.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({Key? key}) : super(key: key);

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  final List<String> _docIDs = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth instance = FirebaseAuth.instance;

  Future getDocId() async {
    _docIDs.clear();
    await firestore
        .collection('absentinfo')
        .orderBy('period', descending: false)
        .get()
        .then((snapshot) {
      for (QueryDocumentSnapshot document in snapshot.docs) {
        _docIDs.add(document.reference.id);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20,),
            Text(
              'Admin Dashboard',
              style: GoogleFonts.bebasNeue(
                  fontWeight: FontWeight.bold, fontSize: 25),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20,),
            Container(
              margin:
              const EdgeInsets.only(left: 5, top: 20, right: 5, bottom: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurpleAccent),
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 550,
                      child: FutureBuilder(
                          future: getDocId(),
                          builder: (context, snapshot) {
                            return ListView.builder(
                              itemCount: _docIDs.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    constraints: BoxConstraints.expand(
                                      height: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .fontSize! *
                                          1.1,
                                    ),
                                    margin: const EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),

                                    child: Center(
                                        child: GetAction(
                                            documentId: _docIDs[index])), //child = Container(list the parameters)
                                  ),
                                );
                              },
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
