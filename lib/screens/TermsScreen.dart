import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentcomp/screens/EditTermScreen.dart';

import '../models/Term.dart';
import '../providers/GPA.dart';

class TermScreen extends StatefulWidget {
  static const String routeName = "Terms";
  @override
  State<TermScreen> createState() => _TermScreenState();
}

class _TermScreenState extends State<TermScreen> {
  late GPA gpa;
  @override
  Widget build(BuildContext context) {
    gpa = Provider.of<GPA>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Terms",
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
          IconButton(
            onPressed: () {
              Term editedTerm = Term(DateTime.now().toString(), "", 0, []);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => EditTermScreen(editedTerm))));
            },
            icon: const Icon(Icons.add),
            splashRadius: 22,
          ),
        ],
      ),
      body: ListView.builder(
          itemBuilder: (ctx, index) {
            Key termKey = ValueKey(gpa.terms[index].id);
            return Dismissible(
              key: termKey,
              background: Container(
                child: const Icon(Icons.delete, color: Colors.white),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(10),
                color: const Color.fromARGB(255, 255, 17, 0),
              ),
              onDismissed: (_) {
                gpa.terms.removeWhere(
                    (element) => element.id == gpa.terms[index].id);
                gpa.calculategpaForAllTerms();
              },
              direction: DismissDirection.endToStart,
              child: Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) =>
                            EditTermScreen(gpa.terms[index]))));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(140, 0, 0, 0),
                    ),
                    height: 85,
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          gpa.terms.elementAt(index).name,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "GPA = ${gpa.terms.elementAt(index).gpa.toStringAsFixed(2)}.",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Color.fromARGB(180, 255, 255, 255),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: gpa.terms.length),
    );
  }
}
