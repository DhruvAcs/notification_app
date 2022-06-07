import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Teacher {
  final int id;
  final String name;

  Teacher({
    required this.id,
    required this.name,
  }
      );
}

class TeacherSelectPage extends StatefulWidget {

  const TeacherSelectPage({Key? key}) : super(key: key);

  @override
  State<TeacherSelectPage> createState() => _TeacherSelectPageState();
}

class _TeacherSelectPageState extends State<TeacherSelectPage> {
  static List<Teacher> _teacher = [
    Teacher(id: 1, name: "teacher 1"),
    Teacher(id: 2, name: "teacher 2"),
    Teacher(id: 3, name: "teacher 3"),
    Teacher(id: 4, name: "teacher 4"),
    Teacher(id: 5, name: "teacher 5"),
    Teacher(id: 6, name: "teacher 6"),

  ];
  final _items = _teacher
      .map((teacher) => MultiSelectItem<Teacher>(teacher, teacher.name))
      .toList();

  List<Teacher> _selectedTeacher = [];
  List<Teacher> _selectedTeacher2 = [];
  List<Teacher> _selectedTeacher3 = [];
  List<Teacher> _selectedTeacher4 = [];
  List<Teacher> _selectedTeacher5 = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    _selectedTeacher5 = _teacher;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Select the teachers you would like to see in your dashboard and get notified when they are absent and what to do!',
                    style: GoogleFonts.bebasNeue(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(25),
                    child: Column(children: <Widget>[
                      SizedBox(height: 10),
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
                        onConfirm: (results) {
                        },
                      ),
                      SizedBox(height: 50),
                    ])),
              ),
            ],
          ),
        ));
  }
}