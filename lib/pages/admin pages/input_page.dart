import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';


class Teacher {
  final int id;
  final String name;

  Teacher({
    required this.id,
    required this.name,
  }
      );
}


class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
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

  Future<void> deleteAll() async {
    final collection = await FirebaseFirestore.instance
        .collection("absentinfo")
        .get();

    final batch = FirebaseFirestore.instance.batch();

    for (final doc in collection.docs) {
      batch.delete(doc.reference);
    }

    return batch.commit();
  }

  @override
  void initState() {
    _selectedTeacher5 = _teacher;
    super.initState();
  }

  final _actionController = TextEditingController();
  final _periodController = TextEditingController();
  final ValueNotifier<DateTime?> dateSub = ValueNotifier(null);
  var teachers = [];
  @override
  void dispose() {
    _actionController.dispose();
    _periodController.dispose();
    super.dispose();
  }

  Future addTeacherabsence(String action, int period, DateTime date) async {
    await FirebaseFirestore.instance.collection('absentinfo').add({
      'action': action,
      'period': period,
      'date': date,
      'teacher': 'ee',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text('Admin'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Input absence information',
                  style: GoogleFonts.bebasNeue(
                      fontWeight: FontWeight.bold, fontSize: 25),
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
                          selectedColor: Colors.black12,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              color: Colors.black12,
                              width: 2,
                            ),
                          ),
                          buttonIcon: Icon(
                            Icons.add,
                            color: Colors.deepPurpleAccent,
                          ),
                          buttonText: Text(
                            "Teacher select",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          onConfirm: (results) {
                            teachers = results;
                            print(teachers);
                          },
                        ),
                        SizedBox(height: 10),
                      ])),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _actionController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors
                            .deepPurpleAccent),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'action',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _periodController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors
                            .deepPurpleAccent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'period',
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ValueListenableBuilder<DateTime?>(
                      valueListenable: dateSub,
                      builder: (context, dateVal, child) {
                        return InkWell(
                            onTap: () async {
                              DateTime? date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2050),
                                  currentDate: DateTime.now(),
                                  initialEntryMode: DatePickerEntryMode.calendar,
                                  initialDatePickerMode: DatePickerMode.day,
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                          colorScheme: const ColorScheme.light(
                                            primary: Colors.deepPurpleAccent,
                                            onSurface: Colors.black,
                                          )
                                      ),
                                      child: child!,
                                    );
                                  });
                              dateSub.value = date;
                            },
                            child: buildDateTimePicker(
                                dateVal != null ? convertDate(dateVal) : ''));
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                //save button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){
                      addTeacherabsence(
                        _actionController.text.trim(),
                        int.parse(_periodController.text.trim()),
                          dateSub.value!

                      );
                      AlertDialog(
                        title: const Text("Saved"),
                      );
                    },
                    child: Container(
                        width: 125,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.deepPurpleAccent),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                          child: Text('Save',
                              style: TextStyle(
                                  color: Colors.deepPurpleAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){
                       deleteAll();
                       AlertDialog(
                         title: const Text("List deleted"),
                       );



                    },
                    child: Container(
                        width: 125,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                          child: Text('Reset List',
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),);
  }
  String convertDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  String convertTime(TimeOfDay timeOfDay) {
    DateTime tempDate = DateFormat('hh:mm').parse(
        timeOfDay.hour.toString() + ':' + timeOfDay.minute.toString());
    var dateFormat = DateFormat('h:mm a');
    return dateFormat.format(tempDate);
  }


  Widget buildDateTimePicker(String data) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(color: Colors.black12, width: 1.5),
        ),
        title: Text(data),
        trailing: const Icon(
          Icons.calendar_today,
          color: Colors.deepPurpleAccent,
        ),
      ),
    );
  }

  Widget buildTextField(
      {String? hint, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: hint ?? '',
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
      ),
    );
  }

}


