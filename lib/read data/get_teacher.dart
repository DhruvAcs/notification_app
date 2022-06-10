import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class GetTeacher extends StatelessWidget {
  final String elementId;

  const GetTeacher({Key? key, required this.elementId}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    CollectionReference teacher = FirebaseFirestore.instance.collection(
        'teacherlist');

    return FutureBuilder<DocumentSnapshot>(future: teacher.doc(elementId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text('${data['teacher']}');
        }
        return const Text('loading...');
      }),
    );
  }
}