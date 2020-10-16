import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AnswerPage extends StatefulWidget {
  List<String> answers;
  AnswerPage(this.answers);
  @override
  _AnswerPageState createState() => _AnswerPageState(answers);
}

class _AnswerPageState extends State<AnswerPage> {
  List<String> answers;
  _AnswerPageState(this.answers);
  var exam = [
    {"type": 'Q/A', "question": "What is your name?"},
    {"type": 'Explain', "question": "Explain the exam?"},
    {"type": 'Y/N', "question": "Are you a man?"},
    {"type": 'T/F', "question": "You are a man"},
    {"type": 'gap', "question": "I am a _______"},
    {
      "type": 'MCQ',
      "question": "2+2 = ?",
      "options": ["1", "2", "3", "4"]
    },
    {
      "type": 'Multipleanswer',
      "question": "2+2 = ?",
      "options": ["1", "2", "3", "4"]
    }
  ];
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
            Text("Your Answer ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.blue)),
            Text(answer,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.blue)),
            Text("Correct Answer ",
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
    for (int i = 0; i < exam.length; i++) {
      widgets.add(questionanswer(exam[i]['question'], ""));
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
