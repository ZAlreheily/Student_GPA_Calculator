import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentcomp/screens/GPAResultScreen.dart';
import '../models/Course.dart';
import '../providers/GPA.dart';
import '../widgets/AddCourse.dart';

class AddGPAScreen extends StatefulWidget {
  static const String routeName = "addGPA";

  @override
  State<AddGPAScreen> createState() => _AddGPAScreenState();
}

class _AddGPAScreenState extends State<AddGPAScreen> {
  var _isInitialGPA = false;
  final _form = GlobalKey<FormState>();
  final _hourFocusNode = FocusNode();
  List<Widget> coursesWidgets = [];
  List<Course> courses = [];
  late GPA gpa;

  @override
  void dispose() {
    _hourFocusNode.dispose();
    super.dispose();
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
    _form.currentState!.save();
    gpa.calculategpa(courses);
    Navigator.of(context).pushReplacementNamed(GPAResultScreen.routeName);
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

  _isInitalGPAtoggle(bool isInitialGPA) {
    setState(() {
      _isInitialGPA = !_isInitialGPA;
    });
  }

  @override
  Widget build(BuildContext context) {
    gpa = Provider.of<GPA>(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Add GPA",
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
              Container(
                alignment: Alignment.center,
                color: Colors.grey.shade500,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "First Semester?",
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    Switch(
                      value: _isInitialGPA,
                      onChanged: _isInitalGPAtoggle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    _isInitialGPA
                        ? Container()
                        : TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue: gpa.currentgpa.toStringAsFixed(2),
                            cursorColor: Colors.red,
                            decoration: const InputDecoration(
                              labelText: 'Current GPA',
                              labelStyle: TextStyle(
                                color: Colors.purple,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(_hourFocusNode);
                            },
                            validator: (value) {
                              if (value == null) {
                                return "";
                              }
                              if (value.isEmpty) {
                                return "Please Enter value.";
                              }
                              try {
                                double.parse(value);
                              } catch (error) {
                                return "Please enter a number";
                              }
                              if ((gpa.isOutOfFive &&
                                      double.parse(value) > 5) ||
                                  (!gpa.isOutOfFive &&
                                      double.parse(value) > 4)) {
                                return "You have exceeded the maximum GPA.";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              gpa.currentgpa = double.parse(value!);
                            }),
                    _isInitialGPA
                        ? Container()
                        : TextFormField(
                            cursorColor: Colors.red,
                            initialValue: gpa.hours.toString(),
                            decoration: const InputDecoration(
                              labelText: 'Current Hours',
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
                              gpa.hours = int.parse(value!);
                            },
                            validator: (value) {
                              if (value == null) {
                                return "";
                              }
                              if (value.isEmpty) {
                                return "Please Enter value.";
                              }
                              try {
                                int.parse(value);
                              } catch (error) {
                                return "Please enter a number";
                              }
                              return null;
                            })
                  ],
                ),
              ),
              _isInitialGPA
                  ? Container()
                  : const Divider(
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
