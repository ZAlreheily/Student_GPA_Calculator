import 'dart:math';

import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../models/Course.dart';
import '../models/Term.dart';
import '../providers/GPA.dart';
import '../widgets/AddCourse.dart';

class EditTermScreen extends StatefulWidget {
  late Term editedTerm;
  EditTermScreen(this.editedTerm, {Key? key}) : super(key: key);
  @override
  State<EditTermScreen> createState() => _EditTermScreenState(editedTerm);
}

class _EditTermScreenState extends State<EditTermScreen> {
  late Term editedTerm;
  final _form = GlobalKey<FormState>();
  late GPA gpa;
  List<Widget> coursesWidgets = [];
  List<Course> courses = [];

  _EditTermScreenState(this.editedTerm);

  @override
  void initState() {
    super.initState();
    courses.addAll(editedTerm.courses);
    editedTerm.courses.forEach((course) {
      Key widgetKey = ValueKey<String>(course.id);
      Key dividerKey = ValueKey<String>(DateTime.now().toString());

      Widget _addCourse = AddCourse(
        key: widgetKey,
        editedCourse: course,
      );
      coursesWidgets.add(
        Dismissible(
          key: widgetKey,
          child: _addCourse,
          background: Container(
            child: const Icon(Icons.delete, color: Colors.white),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(10),
            color: const Color.fromARGB(255, 255, 17, 0),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (_) {
            setState(() {
              coursesWidgets.removeWhere((element) => element.key == widgetKey);
              coursesWidgets
                  .removeWhere((element) => element.key == dividerKey);
              courses.removeWhere(
                (element) => element.id == course.id,
              );
            });
          },
        ),
      );
      coursesWidgets.add(
        Divider(key: dividerKey, thickness: 2),
      );
    });
  }

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    if (courses.isEmpty) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              content: const Text("Please Add Courses to Calculate Your GPA."),
              title: const Text(
                "No Courses Were Added!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                TextButton(
                    child: const Text("Ok",
                        style: TextStyle(color: Colors.purple)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ],
            );
          });
      return;
    }
    editedTerm.courses = courses;
    _form.currentState!.save();
    editedTerm.gpa = gpa.calculategpaForTerm(editedTerm.courses);
    if (!gpa.terms.contains(editedTerm)){
      gpa.addTerm(editedTerm);
    }
    gpa.calculategpaForAllTerms();
    Navigator.pop(context);
  }

  void _addcourse() {
    if (coursesWidgets.length == 14) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      const SnackBar snackBar = SnackBar(
        content: Text(
          "You Cannot Add More Than 7 Courses.",
          style: TextStyle(
            color: Colors.red,
          ),
          textAlign: TextAlign.center,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    setState(() {
      Course editedCourse = Course(name: "", hours: 0, grade: Grades.None);
      courses.add(editedCourse);
      Key widgetKey = ValueKey<String>(editedCourse.id);
      Key dividerKey = ValueKey<String>(DateTime.now().toString());

      Widget _addCourse = AddCourse(
        key: widgetKey,
        editedCourse: editedCourse,
      );
      coursesWidgets.add(
        Dismissible(
          key: widgetKey,
          child: _addCourse,
          background: Container(
            child: const Icon(Icons.delete, color: Colors.white),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(10),
            color: const Color.fromARGB(255, 255, 17, 0),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (_) {
            setState(() {
              coursesWidgets.removeWhere((element) => element.key == widgetKey);
              coursesWidgets
                  .removeWhere((element) => element.key == dividerKey);
              courses.removeWhere(
                (element) => element.id == editedCourse.id,
              );
            });
          },
        ),
      );
      coursesWidgets.add(
        Divider(key: dividerKey, thickness: 2),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    gpa = Provider.of<GPA>(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Edit Term",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.red],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: _saveForm,
              child: const Text(
                "Done",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]),
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextFormField(
                        initialValue: editedTerm.name,
                        cursorColor: Colors.red,
                        decoration: const InputDecoration(
                          labelText: 'Term Name:',
                          labelStyle: TextStyle(
                            color: Colors.purple,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return "";
                          }
                          if (value.isEmpty) {
                            return "Please Enter value.";
                          }

                          return null;
                        },
                        onSaved: (value) {
                          editedTerm.name = value!;
                        }),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(15),
                child: const Text(
                  "Courses:",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple),
                  textAlign: TextAlign.left,
                ),
              ),
              ...coursesWidgets
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: _addcourse,
          backgroundColor: Colors.red),
    );
  }
}
