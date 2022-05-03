import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentcomp/screens/mainScreen.dart';

import '../providers/info.dart';

class AskInfoScreen extends StatefulWidget {
  @override
  State<AskInfoScreen> createState() => _AskInfoScreenState();
}

class _AskInfoScreenState extends State<AskInfoScreen> {
  final _form = GlobalKey<FormState>();
  late Info info;

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState!.save();
    Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    info = Provider.of<Info>(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.red],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 150),
              Material(
                elevation: 45,
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      colors: [Colors.red, Colors.amber],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  child: const Text(
                    "Student GPA Calculator",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  alignment: Alignment.center,
                ),
              ),
              const SizedBox(height: 75),
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.all(5),
                height: 250,
                width: double.infinity,
                child: Card(
                  elevation: 30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Form(
                          key: _form,
                          child: TextFormField(
                            cursorColor: Colors.red,
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              labelText: "Name:",
                              labelStyle: TextStyle(color: Colors.purple),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your Name.";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              info.changeName(value!);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.purple),
                            elevation:
                                MaterialStateProperty.resolveWith<double>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return 15.0;
                                }
                                return 5.0;
                              },
                            ),
                          ),
                          onPressed: _saveForm,
                          child: const Text(
                            "Done",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
