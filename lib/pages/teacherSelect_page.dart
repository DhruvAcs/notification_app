import 'package:flutter/material.dart';
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
        appBar: AppBar(
          backgroundColor: Colors.lightBlue[400],
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: Column(children: <Widget>[
                SizedBox(height: 40),
                MultiSelectDialogField(
                  items: _items,
                  title: Text("teacher"),
                  selectedColor: Colors.lightBlue,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    border: Border.all(
                      color: Colors.lightBlue,
                      width: 2,
                    ),
                  ),
                  buttonIcon: Icon(
                    Icons.add,
                    color: Colors.lightBlue,
                  ),
                  buttonText: Text(
                    "teacher select",
                    style: TextStyle(
                      color: Colors.lightBlue[800],
                      fontSize: 16,
                    ),
                  ),
                  onConfirm: (results) {
                  },
                ),
                SizedBox(height: 50),
              ])),
        ));
  }
}