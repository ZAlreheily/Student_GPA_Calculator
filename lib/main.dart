import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentcomp/providers/info.dart';
import 'package:studentcomp/screens/AskInfoScreen.dart';
import 'package:studentcomp/screens/GPAResultScreen.dart';
import 'package:studentcomp/screens/SettingsScreen.dart';
import 'package:studentcomp/screens/TermsScreen.dart';
import './screens/MainScreen.dart';
import './providers/GPA.dart';
import './screens/AddGPAScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Info(),
        ),
        ChangeNotifierProvider<GPA>(
          create: (_) => GPA(0, 0, false, []),
        ),
      ],
      child: MaterialApp(
        title: 'Student GPA Calculator',
        theme: ThemeData(
          accentColor: Colors.red.shade500,
          fontFamily: "SF",
        ),
        home: AskInfoScreen(),
        routes: {
          AddGPAScreen.routeName: (ctx) => AddGPAScreen(),
          GPAResultScreen.routeName: (ctx) => GPAResultScreen(),
          SettingsScreen.routeName: (ctx) => SettingsScreen(),
          TermScreen.routeName: (ctx) => TermScreen(),
          MainScreen.routeName: (context) => MainScreen(),
        },
      ),
    );
  }
}
