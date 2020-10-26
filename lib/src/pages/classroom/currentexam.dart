import 'package:flutter/material.dart';
import 'package:onlineexamplatform/src/apicalls/examapi.dart';
import 'package:onlineexamplatform/src/models/exams.dart';
import 'package:onlineexamplatform/src/models/questions.dart';
import 'package:onlineexamplatform/src/pages/exam/exampage.dart';
import 'package:onlineexamplatform/src/pages/exam/startpage.dart';
import 'package:intl/intl.dart';

class CurrentExam extends StatefulWidget {
  List<Exam> currentExams;
  CurrentExam(this.currentExams);
  @override
  _CurrentExamState createState() => _CurrentExamState(currentExams);
}

class _CurrentExamState extends State<CurrentExam> {
  List<Exam> currentExams;
  _CurrentExamState(this.currentExams);
  void joinexam(int i) async {
    ExamApi examApi = new ExamApi();
    List<Question> questions = await examApi.getQuestions("12");
    setState(() {
      currentExams[i].examQuestions = questions;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return StartPage(currentExams[i]);
          },
        ),
      );
    });
  }

  Widget currentExam(int index, Exam e) {
    String answer = "";
    String teacher = "conducted by " + e.examCreator;
    var date = new DateTime.fromMicrosecondsSinceEpoch(e.examTime);
    var formattedDate = DateFormat.yMd().add_jm().format(date);
    if (e.examStart) {
      answer = "Tap to start the exam";
    }
    return InkWell(
      onTap: () {
        if (e.examStart) {
          joinexam(index);
        } else {}
      },
      child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          e.examName,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          teacher,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 18, fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Subject: ",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          e.examSubject,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Time: ",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            answer,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: VerticalDivider(
                  thickness: 2,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 70,
                  //margin: EdgeInsets.all(100.0),
                  decoration:
                      BoxDecoration(color: Colors.teal, shape: BoxShape.circle),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        e.examMarks.toString(),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "marks",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            itemCount: currentExams.length,
            itemBuilder: (context, index) {
              return currentExam(index + 1, currentExams[index]);
            }));
  }
}
