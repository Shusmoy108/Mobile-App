import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlineexamplatform/src/apicalls/examapi.dart';
import 'package:onlineexamplatform/src/models/exams.dart';
import 'package:onlineexamplatform/src/models/questions.dart';
import 'package:onlineexamplatform/src/pages/exam/answerscript.dart';
import 'package:onlineexamplatform/src/pages/exam/exampage.dart';
import 'package:onlineexamplatform/src/pages/exam/resultpage.dart';
import 'package:onlineexamplatform/src/pages/exam/startpage.dart';
import 'package:intl/intl.dart';

class Calender extends StatefulWidget {
  List<Exam> currentExams, previouExam;
  Calender(this.currentExams, this.previouExam);
  @override
  _CalenderState createState() => _CalenderState(currentExams, previouExam);
}

class _CalenderState extends State<Calender> {
  List<Exam> currentExams, previousExam;
  _CalenderState(this.currentExams, this.previousExam);
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
  void showAnswer(int i) async {
    ExamApi examApi = new ExamApi();
    List<Question> questions = await examApi.getAnswers("12");
    setState(() {
      previousExam[i].examQuestions = questions;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return AnswerPage(previousExam[i]);
          },
        ),
      );
    });
  }
  Widget OngoingExam(int index, Exam e) {
    String teacher = "conducted by " + e.examCreator;
    var date = new DateTime.fromMicrosecondsSinceEpoch(e.examTime);
    var formattedDate = DateFormat.yMd().add_jm().format(date);
    String answer = "";
    if (e.examStart) {
      answer = "Tap to start the exam";
    }
    return InkWell(
      onTap: () {
        if (e.examStart) {
          joinexam(index);
        }
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        //height: 100.0,
        //height: 300.0,
        width: 220,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Text(
                  e.examName,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  teacher,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
              mainAxisAlignment: MainAxisAlignment.center,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  answer,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
            //Divider(),
          ],

//              new Align(
//                alignment: Alignment.bottomCenter,
//                child: startbutton(),
//              ),
        ),
      ),
    );
  }

  Widget previousexam(int index, Exam e) {
    String answer = "";
    String teacher = "conducted by " + e.examCreator;
    var date = new DateTime.fromMicrosecondsSinceEpoch(e.examTime);
    var formattedDate = DateFormat.yMd().add_jm().format(date);

    if (e.examAnswerAvailable) {
      answer =
          "Answer Script is available of this exam. Tap to see the answer script";
    }
    return InkWell(
        onTap: () {
      if (e.examAnswerAvailable) {
        showAnswer(index);
      }
    },
    child:Container(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        e.examName,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        teacher,
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
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "marks",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )
          ],
        )));
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    final headerList = new ListView.builder(
      itemBuilder: (context, index) {
        return OngoingExam(index + 1, currentExams[index]);
      },
      scrollDirection: Axis.horizontal,
      itemCount: currentExams.length,
    );

    return new Container(
      child: new Stack(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(top: 10.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Align(
                  alignment: Alignment.centerLeft,
                  child: new Padding(
                      padding: new EdgeInsets.only(left: 8.0),
                      child: new Text(
                        'Ongoing Exams',
                        style: new TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                ),
                Divider(
                  thickness: 2,
                ),
                new Container(height: 240.0, width: _width, child: headerList),
                new Text(
                  'Previous Exams',
                  style: new TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Divider(
                  thickness: 2,
                ),
                new Expanded(
                    child: ListView.builder(
                        itemCount: previousExam.length,
                        itemBuilder: (context, index) {
                          return previousexam(index + 1, previousExam[index]);
                        }))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
