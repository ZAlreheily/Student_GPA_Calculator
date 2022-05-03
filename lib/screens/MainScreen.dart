import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentcomp/screens/AddGPAScreen.dart';
import 'package:studentcomp/screens/SettingsScreen.dart';
import 'package:studentcomp/screens/TermsScreen.dart';
import '../providers/GPA.dart';
import '../providers/info.dart';

class MainScreen extends StatelessWidget {
  static const String routeName = "MainScreen";
  @override
  Widget build(BuildContext context) {
    GPA gpa = Provider.of<GPA>(context);
    Info info = Provider.of<Info>(context);
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 206, 204, 204),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.red],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        title: const Text(
          "Student GPA Calculator",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //       bottomLeft: Radius.circular(200),
        //       bottomRight: Radius.circular(200)),
        //   // side: BorderSide(width: 2, color: Colors.blue),
        // ),
        centerTitle: true,
        elevation: 15,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  height: 70,
                  width: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(60, 8, 75, 129),
                  ),
                  margin: const EdgeInsets.only(top: 15, right: 290),
                ),
                bottom: 45,
                left: 65,
              ),
              Container(
                child: Text(
                  "Welcome ${info.name}!\n",
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                padding: const EdgeInsets.only(
                  bottom: 45,
                  right: 150,
                  left: 15,
                ),
              ),
            ],
          ),
        ),
        actions: [
          LimitedBox(
            maxHeight: 40,
            maxWidth: 40,
            child: //Stack(
                //   children: [
                // Positioned(
                //     child: Container(
                //       height: 30,
                //       width: 30,
                //       decoration: const BoxDecoration(
                //         shape: BoxShape.circle,
                //         color: Color.fromARGB(100, 0, 0, 0),
                //       ),
                //     ),
                //     top: 10,
                //     left: 5),
                IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).pushNamed(SettingsScreen.routeName);
              },
              color: Colors.white,
              splashRadius: 16,
              //   ),
              // ],
            ),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: Stack(
        children: [
          Positioned(
            child: Container(
              height: 75,
              width: 75,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(100, 124, 126, 128),
              ),
            ),
            right: 35,
            top: 70,
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () {
                      if (gpa.terms.isNotEmpty) {
                        showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              content: const Text("This Will Delete All Terms"),
                              title: const Text(
                                "Are You Sure?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              actions: [
                                TextButton(
                                    child: const Text("Cancel",
                                        style: TextStyle(color: Colors.purple)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }),
                                TextButton(
                                    child: const Text("Yes",
                                        style: TextStyle(color: Colors.purple)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      gpa.clear();
                                      Navigator.of(context)
                                          .pushNamed(AddGPAScreen.routeName);
                                    }),
                              ],
                            );
                          },
                        );
                        return;
                      }
                      Navigator.of(context).pushNamed(AddGPAScreen.routeName);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(140, 0, 0, 0),
                      ),
                      height: 150,
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        gpa.currentgpa == 0
                            ? "One Time Calculation for GPA."
                            : "Your GPA is ${gpa.currentgpa.toStringAsFixed(2)}.",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(TermScreen.routeName);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(140, 0, 0, 0),
                      ),
                      height: 150,
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      child: const Text(
                        "Manage Terms!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
