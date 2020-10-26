import 'package:flutter/material.dart';
import 'package:onlineexamplatform/src/apicalls/examapi.dart';
import 'package:onlineexamplatform/src/pages/home/studenthome.dart';
import 'package:onlineexamplatform/src/pages/registration/initialpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apicalls/classroomapi.dart';
import 'models/classrooms.dart';
import 'models/exams.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  List<Classroom> classes;
  List<Exam> currentExams, previousExams;
  Future<bool> loadAuthData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    ClassroomApi classroomApi = new ClassroomApi();
    classes = await classroomApi.getClassrooms("12");
    ExamApi examApi = new ExamApi();
    var exams = await examApi.getExams("12");
//    if(res!=null){
    //var exams = jsonDecode(res);
    currentExams = new List();
    for (var e in exams['currentExam']) {
      Exam er = new Exam(e["_id"], e["examName"], e["examInstruction"],
          e["examSubject"], e["examCreator"], e["examTime"], e["examMarks"]);
      er.examStart = e["examStart"];
      er.examDuration = e["examDuration"];
      currentExams.add(er);
    }
    previousExams = new List();
    for (var e in exams['previousExam']) {
      Exam er = new Exam(e["_id"], e["examName"], e["examInstruction"],
          e["examSubject"], e["examCreator"], e["examTime"], e["examMarks"]);
      er.examAnswerAvailable = e["examAnswerAvailable"];
      er.examDuration = e["examDuration"];
      previousExams.add(er);
    }
    print(sp.getBool('auth'));
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
              return StudentHome(classes, currentExams, previousExams);
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
