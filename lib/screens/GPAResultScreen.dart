import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/GPA.dart';

class GPAResultScreen extends StatelessWidget {
  static const String routeName = "GPAResult";
  late GPA gpa;
  @override
  Widget build(BuildContext context) {
    gpa = Provider.of<GPA>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Result GPA",
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
      body: Center(
        child: Container(
          height: 75,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey.shade500),
          margin: const EdgeInsets.all(15),
          child: Text(
            "Your GPA is ${gpa.currentgpa.toStringAsFixed(2)}.",
            style: const TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
