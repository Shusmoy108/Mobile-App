import 'package:flutter/material.dart';
import 'package:onlineexamplatform/src/apicalls/examapi.dart';
import 'package:onlineexamplatform/src/models/exams.dart';
import 'package:onlineexamplatform/src/models/questions.dart';
import 'package:onlineexamplatform/src/pages/exam/answerscript.dart';
import 'package:onlineexamplatform/src/pages/exam/exampage.dart';
import 'package:intl/intl.dart';

class PreviousExam extends StatefulWidget {
  List<Exam> previousExams;
  PreviousExam(this.previousExams);
  @override
  _PreviousExamState createState() => _PreviousExamState(previousExams);
}

class _PreviousExamState extends State<PreviousExam> {
  List<Exam> previousExams;
  _PreviousExamState(this.previousExams);
  void showAnswer(int i) async {
    ExamApi examApi = new ExamApi();
    List<Question> questions = await examApi.getAnswers("12");
    setState(() {
      previousExams[i].examQuestions = questions;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return AnswerPage(previousExams[i]);
          },
        ),
      );
    });
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
                      Text(
                        e.examName,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
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

  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            itemCount: previousExams.length,
            itemBuilder: (context, index) {
              return previousexam(index + 1, previousExams[index]);
            }));
  }
}
