import 'package:flutter/material.dart';
import 'package:onlineexamplatform/src/home/studenthome.dart';
import 'package:onlineexamplatform/src/registration/initialpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  Future<bool> loadAuthData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool('auth');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Master',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: loadAuthData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return StudentHome("");
            } else {
              return InitialPage();
            }
          } else {
            return InitialPage();
          }
        },
      ),
    );
  }
}
