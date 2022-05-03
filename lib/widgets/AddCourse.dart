import 'package:flutter/material.dart';

import '../models/Course.dart';

class AddCourse extends StatefulWidget {
  Course editedCourse;
  AddCourse({Key? key, required this.editedCourse}) : super(key: key);

  @override
  State<AddCourse> createState() => _AddCourseState(editedCourse);
}

class _AddCourseState extends State<AddCourse> {
  final _hourFocusNode = FocusNode();
  final _gradeFocusNode = FocusNode();
  late Course editedCourse;
  _AddCourseState(this.editedCourse);

  @override
  void dispose() {
    _hourFocusNode.dispose();
    _gradeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade500,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              cursorColor: Colors.red,
              initialValue: editedCourse.name,
              decoration: const InputDecoration(
                labelText: 'Course Name:',
                labelStyle: TextStyle(
                  color: Colors.purple,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_hourFocusNode);
              },
              onSaved: (value) {
                editedCourse.name = value!;
              },
              validator: (value) {
                if (value == null) {
                  return "";
                }
                if (value.isEmpty) {
                  return "Please Enter Name.";
                }
                return null;
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue:
                  editedCourse.hours == 0 ? "" : editedCourse.hours.toString(),
              cursorColor: Colors.red,
              decoration: const InputDecoration(
                labelText: 'Course Hours:',
                labelStyle: TextStyle(
                  color: Colors.purple,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              keyboardType: TextInputType.number,
              focusNode: _hourFocusNode,
              onSaved: (value) {
                editedCourse.hours = int.parse(value!);
              },
              validator: (value) {
                if (value == null) {
                  return "";
                }
                if (value.isEmpty) {
                  return "Please Enter Value.";
                }
                try {
                  int.parse(value);
                } catch (error) {
                  return "Please Enter Number";
                }
                return null;
              },
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_gradeFocusNode);
              },
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Grade:",
                  style: TextStyle(color: Colors.purple, fontSize: 17),
                ),
              ),
              Expanded(
                child: DropdownButtonFormField<Grades>(
                  iconEnabledColor: Colors.purple,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(child: Text("A+"), value: Grades.AP),
                    DropdownMenuItem(child: Text("A"), value: Grades.A),
                    DropdownMenuItem(child: Text("B+"), value: Grades.BP),
                    DropdownMenuItem(child: Text("B"), value: Grades.B),
                    DropdownMenuItem(child: Text("C+"), value: Grades.CP),
                    DropdownMenuItem(child: Text("C"), value: Grades.C),
                    DropdownMenuItem(child: Text("D+"), value: Grades.DP),
                    DropdownMenuItem(child: Text("D"), value: Grades.D),
                    DropdownMenuItem(child: Text("F"), value: Grades.F),
                  ],
                  onChanged: (value) {},
                  onSaved: (value) {
                    editedCourse.grade = value!;
                  },
                  focusNode: _gradeFocusNode,
                  validator: (value) {
                    if (value == null) {
                      return "Please Select Grade";
                    }
                    return null;
                  },
                  value: editedCourse.grade == Grades.None
                      ? null
                      : editedCourse.grade,
                ),
              ),
            ],
          ),
        )
      ], crossAxisAlignment: CrossAxisAlignment.start),
    );
  }
}
