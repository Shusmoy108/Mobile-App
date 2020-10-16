import 'package:flutter/material.dart';
import 'package:onlineexamplatform/src/pages/exam/exampage.dart';
import 'package:onlineexamplatform/src/pages/exam/startpage.dart';

class CurrentExam extends StatefulWidget {
  @override
  _CurrentExamState createState() => _CurrentExamState();
}

class _CurrentExamState extends State<CurrentExam> {
  void joinexam() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return StartPage();
        },
      ),
    );
  }

  Widget startbutton() {
    return InkWell(
      onTap: () {
        joinexam();
      },
      child: Container(
        width: 70,
        height: 30,
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
              'Start',
              style: TextStyle(
                  color: Colors.white, fontSize: 15.0, fontFamily: 'Merienda'),
            ),
            SizedBox(
              width: 0.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget currentExam(int index, String examname, String teacher, bool ans) {
    String answer = "Tap to start the exam";
    teacher = "conducted by " + teacher;

    return new ListTile(
      onTap: () {
        print("tapped");
        joinexam();
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
                  ),
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
      return currentExam(index + 1, "Physics", "Prottoy", true);
    }));
  }
}
