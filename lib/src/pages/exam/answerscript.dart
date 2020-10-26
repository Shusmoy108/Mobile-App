import 'package:flutter/material.dart';
import 'package:onlineexamplatform/src/models/exams.dart';

// ignore: must_be_immutable
class AnswerPage extends StatefulWidget {
  Exam e;
  AnswerPage(this.e);
  @override
  _AnswerPageState createState() => _AnswerPageState(e);
}

class _AnswerPageState extends State<AnswerPage> {
  Exam e;
  _AnswerPageState(this.e);
  Widget questionanswer(String question, String answer) {
    return Card(
      child: Container(
        child: Column(
          children: <Widget>[
            Text(question,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.orange)),
            Text("Answer ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.green)),
            Text(answer,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.green))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < e.examQuestions.length; i++) {
      widgets.add(questionanswer(e.examQuestions[i].question, e.examQuestions[i].answer));
      widgets.add(SizedBox(
        height: 10,
      ));
    }
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.teal,
          title: Text("Quiz Master")),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: widgets),
        ),
      ),
    );
  }
}
