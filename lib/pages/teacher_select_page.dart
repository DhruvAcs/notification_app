import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherSelectPage extends StatefulWidget {
  const TeacherSelectPage({Key? key}) : super(key: key);

  @override
  State<TeacherSelectPage> createState() => _TeacherSelectPageState();
}

class _TeacherSelectPageState extends State<TeacherSelectPage> {
  static final List<String> _teacherNames = [];
  final List<MultiSelectItem<String>> _items = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth instance = FirebaseAuth.instance;

  // document IDS for teachers
  final List<String> _teacherDocIds = [];

  List<String> _savedTeachers = [];
  List<String> _savedTeacherNames = ['No Saved Teachers'];

  //get teacher docids
  Future getTDocId() async {
    await firestore.collection('teacherlist').get().then((snapshot) {
      for (var element in snapshot.docs) {
        _teacherNames.add(element['prefix'] + element['lastName']);
        _teacherDocIds.add(element.reference.id);
      }
      for (int i = 0; i < _teacherDocIds.length; i++) {
        _items.add(MultiSelectItem<String>(_teacherDocIds[i], _teacherNames[i]));
      }
      setState(() {});
    });

  }

  Future getSavedTeachers() async {
    _savedTeachers.clear();
    _savedTeacherNames.clear();
    await firestore.collection('users').doc(instance.currentUser?.uid).get().then((value) {
      _savedTeachers = List<String>.from(value.data()!['savedteachers']);
      setState(() {});
    });
    if (_savedTeachers.isEmpty) {_savedTeacherNames = ['No Saved Teachers']; setState(() {}); return;}
    await firestore.collection('teacherlist').where(FieldPath.documentId, whereIn: _savedTeachers).get().then((QuerySnapshot qs) {
      for (var element in qs.docs) {
        _savedTeacherNames.add(element['prefix'] + element['lastName']);
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getSavedTeachers().then((e) => getTDocId());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding (
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40,),
            Text(
              'Select the teachers you would like to see in your dashboard and get notified when they are absent and what to do!',
              style: GoogleFonts.bebasNeue(fontSize: 20),
            ),
            const SizedBox(height: 10,),
            SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                padding:const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  children: <Widget>[
                    FutureBuilder<DocumentSnapshot>(
                      future: firestore.collection('users').doc(instance.currentUser?.uid).get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                          List<String> _initialSelectedItems = [];

                          for (String teacher in data['savedteachers']) {
                            _initialSelectedItems.add(teacher);
                          }
                          return MultiSelectDialogField<String?>(
                            initialValue: _initialSelectedItems,
                            searchable: true,
                            items: _items,
                            title: const Text("teacher"),
                            selectedColor: Colors.deepPurpleAccent,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                color: Colors.deepPurpleAccent,
                                width: 2,
                              ),
                            ),
                            buttonIcon: const Icon(
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
                            onConfirm: (results) {
                              firestore.collection('users').doc(
                                  instance.currentUser?.uid).update(
                                  {'savedteachers': results});
                              getSavedTeachers();
                            },
                            onSelectionChanged: (results) {
                              firestore.collection('users').doc(
                                  instance.currentUser?.uid).update(
                                  {'savedteachers': results});
                            },

                          );
                        }
                        return const Text('Loading...');
                      },
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40,),
            Text(
              'Your Selected Teachers:',
              style: GoogleFonts.bebasNeue(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _savedTeacherNames.length,
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
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(_savedTeacherNames[index])
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
