import 'package:flutter/material.dart';
import 'package:onlineexamplatform/src/apicalls/classroomapi.dart';
import 'package:onlineexamplatform/src/models/classrooms.dart';
import 'package:onlineexamplatform/src/models/exams.dart';
import 'package:onlineexamplatform/src/pages/exam/answerscript.dart';
import 'package:onlineexamplatform/src/pages/home/studenthome.dart';

// ignore: must_be_immutable
class ResultPage extends StatefulWidget {
  List<String> answers;
  ResultPage();
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<ResultPage> {
  List<String> answers;
  _ResultState();
  void exam() async {
    ClassroomApi classroomApi = new ClassroomApi();
    List<Classroom> classrooms = await classroomApi.getClassrooms("12");
    var exams = await classroomApi.getClassroomExams("12");
//    if(res!=null){
    //var exams = jsonDecode(res);
    List<Exam> currentExams = new List();
    for (var e in exams['currentExam']) {
      Exam er = new Exam(e["_id"], e["examName"], e["examInstruction"],
          e["examSubject"], e["examCreator"], e["examTime"], e["examMarks"]);
      er.examStart = e["examStart"];
      er.examDuration = e["examDuration"];
      currentExams.add(er);
    }
    List<Exam> previousExams = new List();
    for (var e in exams['previousExam']) {
      Exam er = new Exam(e["_id"], e["examName"], e["examInstruction"],
          e["examSubject"], e["examCreator"], e["examTime"], e["examMarks"]);
      er.examAnswerAvailable = e["examAnswerAvailable"];
      er.examDuration = e["examDuration"];
      previousExams.add(er);
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return StudentHome(classrooms, currentExams, previousExams);
        },
      ),
    );
  }

  void answer() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          //return AnswerPage(answers);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.teal,
          title: Text("Quiz Master")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  child: Text("Thank You for attending the exam.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.orange))),
              SizedBox(
                height: 25,
              ),
              Container(
                  alignment: Alignment.center,
                  child: Text("Your result will be given soon.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.orange))),
              SizedBox(
                height: 25,
              ),
              Container(
                  alignment: Alignment.center,
                  child: Text(
                      "You will be notified about your result through sms.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.orange))),
              SizedBox(
                height: 50,
              ),
              submitbutton(),
              SizedBox(
                height: 20,
              ),
              // answerbutton()
            ],
          ),
        ),
      ),
    );
  }

  Widget submitbutton() {
    return InkWell(
      onTap: () {
        exam();
      },
      child: Container(
        width: 250,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            //BoxShadow(color: Colors.grey, offset: Offset(1, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Home',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            SizedBox(
              width: 0.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget answerbutton() {
    return InkWell(
      onTap: () {
        answer();
      },
      child: Container(
        width: 250,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            //BoxShadow(color: Colors.grey, offset: Offset(1, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Show Answer Script',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            SizedBox(
              width: 0.0,
            ),
          ],
        ),
      ),
    );
  }
}
