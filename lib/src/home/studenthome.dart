import 'package:flutter/material.dart';
import 'package:onlineexamplatform/src/exam/startpage.dart';

class StudentHome extends StatefulWidget {
  String mobile;
  StudentHome(this.mobile);

  @override
  _StudentHomeState createState() => _StudentHomeState(mobile);
}

class _StudentHomeState extends State<StudentHome> {
  String mobile;
  _StudentHomeState(this.mobile);
  void joinexam() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return StartPage();
        },
      ),
    );
  }

  Widget joinbutton() {
    return InkWell(
      onTap: () {
        joinexam();
      },
      child: Container(
        width: 200,
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
              'Join Exam',
              style: TextStyle(
                  color: Colors.white, fontSize: 20.0, fontFamily: 'Merienda'),
            ),
            SizedBox(
              width: 0.0,
            ),
          ],
        ),
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
        body: Container(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              joinbutton(),
            ],
          ),
        )));
  }
}
