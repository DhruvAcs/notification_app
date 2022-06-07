import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetAction extends StatelessWidget {
  final String documentId;

  GetAction({required this.documentId}){

  }


  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection(
        'absentinfo');

    return FutureBuilder<DocumentSnapshot>(future: users.doc(documentId).get(),
      builder: ((context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data = snapshot.data!.data() as Map<String,
            dynamic>;
        return Text('${data['teacher']}' + '  |  ' 'Period: ${data['period']}' +'  |  '+ ' ${data['action']}');
      }
      return Text('loading...');
    }),
    );
  }
}
