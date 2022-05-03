import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/GPA.dart';
import '../providers/info.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = "Settings";

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late Info info;
  late GPA gpa;
  @override
  Widget build(BuildContext context) {
    info = Provider.of<Info>(context);
    gpa = Provider.of<GPA>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          TextField(
            decoration: InputDecoration(
              labelText: "Name:",
              labelStyle: const TextStyle(
                color: Colors.purple,
              ),
              hintText: info.name,
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
            cursorColor: Colors.red,
            onChanged: (value) {
              info.changeName(value);
            },
          ),
          const SizedBox(height: 50),
          Row(
            children: [
              const Text(
                "Use GPA out of 5? ",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Switch(
                  value: gpa.isOutOfFive,
                  onChanged: (value) {
                    gpa.toggleisOutOfFive();
                  })
            ],
          )
        ]),
      ),
    );
  }
}
