import 'package:flutter/material.dart';
import 'package:onlineexamplatform/src/pages/home/studenthome.dart';
import 'package:onlineexamplatform/src/pages/registration/initialpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apicalls/classroomapi.dart';
import 'models/classrooms.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  List<Classroom>  classes;
  Future<bool> loadAuthData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    ClassroomApi classroomApi= new ClassroomApi();
    classes=  await classroomApi.getClassrooms("12");
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
              return StudentHome(classes);
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
