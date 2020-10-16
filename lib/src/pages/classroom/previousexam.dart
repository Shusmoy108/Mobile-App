import 'package:flutter/material.dart';
import 'package:onlineexamplatform/src/pages/exam/answerscript.dart';
import 'package:onlineexamplatform/src/pages/exam/exampage.dart';

class PreviousExam extends StatefulWidget {
  @override
  _PreviousExamState createState() => _PreviousExamState();
}

class _PreviousExamState extends State<PreviousExam> {
  Widget previousexam(int index, String examname, String teacher, bool ans) {
    String answer = "";
    teacher = "conducted by " + teacher;

    if (index % 3 == 0) {
      answer =
          "Answer Script is available of this exam. Tap to see the answer script";
    }
    return new ListTile(
      onTap: () {
        print("tapped");
        if (index % 3 == 0) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return AnswerPage([]);
              },
            ),
          );
        }
      },
      title: new Column(
        children: <Widget>[
          new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                height: 72.0,
                width: 72.0,
                decoration: new BoxDecoration(
                  color: Colors.lightGreen,
                  boxShadow: [
                    new BoxShadow(
                        color: Colors.black.withAlpha(70),
                        offset: const Offset(2.0, 2.0),
                        blurRadius: 2.0)
                  ],
                  borderRadius: new BorderRadius.all(new Radius.circular(12.0)),
                ),
              ),
              new SizedBox(
                width: 8.0,
              ),
              new Expanded(
                  child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    examname,
                    style: new TextStyle(
                        fontSize: 14.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  new Text(
                    teacher,
                    style: new TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.normal),
                  ),
                  new Text(
                    "Exam time: 10/5/2020, 3.00 pm- 5.00 pm",
                    style: new TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.normal),
                  ),
                  new Text(
                    answer,
                    style: new TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.normal),
                  )
                ],
              )),
            ],
          ),
          new Divider(),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(child: ListView.builder(itemBuilder: (context, index) {
      return previousexam(index + 1, "Physics", "Prottoy", true);
    }));
  }
}
