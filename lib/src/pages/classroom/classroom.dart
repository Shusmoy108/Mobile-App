import 'package:flutter/material.dart';
import 'package:onlineexamplatform/src/apicalls/classroomapi.dart';
import 'package:onlineexamplatform/src/models/classrooms.dart';
import 'package:onlineexamplatform/src/models/exams.dart';
import 'package:onlineexamplatform/src/pages/classroom/classes.dart';

class ClassroomPage extends StatefulWidget {
  ClassroomPage(this.classrooms);
  List<Classroom> classrooms;
  @override
  _ClassroomState createState() => _ClassroomState(classrooms);
}

class _ClassroomState extends State<ClassroomPage> {
  List<Classroom> classrooms;
  _ClassroomState(this.classrooms);
  Future<List<Classroom>> getClasses() async {
//    ClassroomApi classroomApi= new ClassroomApi();
//    List<Classroom>  classes=  await classroomApi.getClassrooms("12");
//    setState(() {
//      classrooms=classes;
//    });
    return classrooms;
  }

  void seeExams(String classId) async {
    ClassroomApi classroomApi = new ClassroomApi();
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
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Classes(classId, currentExams, previousExams);
        },
      ),
    );
//    }

    //print(res.runtimeType);
  }

  @override
  Widget classroom(int i, String classname, String description, String teacher,
      String examNumber) {
    teacher = "conducted by " + teacher;
    String exam = examNumber + " exams";
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          seeExams(classname);
        },
        child: ListTile(
          leading: Text(
            i.toString(),
            style: TextStyle(fontSize: 20),
          ),
          title: Text(classname),
          subtitle: Text(teacher),
          trailing: Text(exam),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getClasses(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return new ListView.builder(
                  itemCount: classrooms.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return classroom(
                        index + 1,
                        classrooms[index].roomName,
                        classrooms[index].roomDescription,
                        classrooms[index].roomCreator,
                        classrooms[index].roomExam);
                  });
            } else {
              return Text("You are not joined to any classroom");
            }
          } else {
            return Text("Network Problem");
          }
        },
      ),
    );
  }
}
