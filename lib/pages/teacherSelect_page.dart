import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notification_app/read%20data/get_teacher.dart';

class TeacherSelectPage extends StatefulWidget {
  const TeacherSelectPage({Key? key}) : super(key: key);

  @override
  State<TeacherSelectPage> createState() => _TeacherSelectPageState();
}

class _TeacherSelectPageState extends State<TeacherSelectPage> {
  static List<String> _teacher = [];
  List<MultiSelectItem<String>> _items = [];

  // document IDS for teachers
  List<String> tdocsIDs = [];

  //get teacher docids
  Future getTDocId() async {
    await FirebaseFirestore.instance
        .collection('teacherlist')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        _teacher.add(element['teacher']);
        //print(element.reference);
        tdocsIDs.add(element.reference.id);
      });
      _items = _teacher
          .map((teacher) => MultiSelectItem<String>(teacher, teacher))
          .toList();
      // print('i'+ _items.toString() );
      // print('t'+ _teacher.toString());
      //print(tdocsIDs);
      setState(() {});
    });
  }

  @override
  void initState() {
    _teacher.clear();
    getTDocId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 5.0),
                  child: Text(
                    'Select the teachers you would like to see in your dashboard and get notified when they are absent and what to do!',
                    style: GoogleFonts.bebasNeue(fontSize: 20),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Column(children: <Widget>[
                    MultiSelectBottomSheetField(
                      items: _items,
                      title: Text("teacher"),
                      selectedColor: Colors.deepPurpleAccent,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: Colors.deepPurpleAccent,
                          width: 2,
                        ),
                      ),
                      buttonIcon: Icon(
                        Icons.add,
                        color: Colors.deepPurpleAccent,
                      ),
                      buttonText: Text(
                        "Teacher Select",
                        style: TextStyle(
                          color: Colors.deepPurpleAccent[800],
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: (results) {},
                    ),
                  ])),
            ),
            Container(
              child: Expanded(
                child: ListView.builder(
                  itemCount: tdocsIDs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        constraints: BoxConstraints.expand(
                          height:
                              Theme.of(context).textTheme.headline4!.fontSize! *
                                  1.1,
                        ),
                        margin: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                            child: GetTeacher(elementId: tdocsIDs[index])),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
