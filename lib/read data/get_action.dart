import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetAction extends StatelessWidget {
  final String documentId;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final String teacherid;

  GetAction({Key? key, required this.documentId}) : super(key: key);

  Future getData() async {
    await firestore.collection('absentinfo').doc(documentId).get().then((value) {
      Map<String, dynamic> data = value.data()!;
      teacherid = data['teacherid'];
      // print(data['teacherid']);
    });
    DocumentSnapshot ds1 = await firestore.collection('absentinfo').doc(documentId).get();
    DocumentSnapshot ds2 = await firestore.collection('teacherlist').doc(teacherid).get();
    return [ds1, ds2];
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: getData(),
      builder: ((context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        List data = snapshot.data! as List;
        // print(data.toString());
        // print('${data[1]['prefix']}' + '${data[1]['lastName']}' + '  |  ' 'Period: ${data[0]['period']}' +'  |  '+ ' ${data[0]['action']}');
        // Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;

        return Text('${data[1]['prefix']}' + '${data[1]['lastName']}' + '  |  ' 'Period: ${data[0]['period']}' +'  |  '+ ' ${data[0]['action']}');
      }
      return Text('loading...');
    }),
    );
  }
}
