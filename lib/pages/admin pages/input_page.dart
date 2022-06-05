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

  @override
  void initState() {
    _selectedTeacher5 = _teacher;
    super.initState();
  }

  final _actionController = TextEditingController();
  final _periodController = TextEditingController();
  final ValueNotifier<DateTime?> dateSub = ValueNotifier(null);
  final ValueNotifier<DateTime?> longDateSub = ValueNotifier(null);
  final ValueNotifier<TimeOfDay?> timeSub = ValueNotifier(null);
  final ValueNotifier<TimeOfDay?> timeSubShort = ValueNotifier(null);

  @override
  void dispose() {
    _actionController.dispose();
    _periodController.dispose();
    super.dispose();
  }

  Future addTeacherabsesnce(String action,int period) async {
    await FirebaseFirestore.instance.collection('absentinfo').add({
      'action': action,
      'period': period,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      padding: EdgeInsets.all(20),
                      child: Column(children: <Widget>[
                        SizedBox(height: 10),
                        MultiSelectDialogField(
                          items: _items,
                          title: Text("teacher"),
                          selectedColor: Colors.black12,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            border: Border.all(
                              color: Colors.black12,
                              width: 2,
                            ),
                          ),
                          buttonIcon: Icon(
                            Icons.add,
                            color: Colors.lightBlue,
                          ),
                          buttonText: Text(
                            "Teacher select",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          onConfirm: (results) {
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
                            .lightBlueAccent),
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
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors
                            .lightBlueAccent),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'period',
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                const SizedBox(height: 10),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Date',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                ValueListenableBuilder<DateTime?>(
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
                                          primary: Colors.lightBlue,
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
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Time',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18.0),
                ),
                ValueListenableBuilder<TimeOfDay?>(
                    valueListenable: timeSubShort,
                    builder: (context, timeVal, child) {
                      return InkWell(
                          onTap: () async {
                            TimeOfDay? time = await showTimePicker(
                              context: context,
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context)
                                  child: child!,
                                );
                              },
                              initialTime: TimeOfDay.now(),
                            );
                            timeSubShort.value = time;
                          },
                          child: buildDateTimePicker(timeVal != null
                              ? convertTime(timeVal)
                              : ''));
                    }),
                //save button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){
                      addTeacherabsesnce(
                        _actionController.text.trim(),
                        int.parse(_periodController.text.trim()),

                      );
                    },
                    child: Container(
                        width: 125,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.lightBlueAccent[100],
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                          child: Text('Save',
                              style: TextStyle(
                                  color: Colors.white,
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
          color: Colors.lightBlue,
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
          borderSide: const BorderSide(color: Colors.lightBlue, width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.lightBlue, width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
      ),
    );
  }

}


