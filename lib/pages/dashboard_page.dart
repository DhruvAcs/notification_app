import 'package:flutter/material.dart';
import 'package:notification_app/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notification_app/read%20data/get_action.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance.collection('absentinfo').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
        print(document.reference);
        docIDs.add(document.reference.id);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        title: Text('Welcome ' +
          user.email!,
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(future: getDocId(),builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: docIDs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: GetAction(documentId: docIDs[index]),
                        tileColor: Colors.grey.shade200,
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}