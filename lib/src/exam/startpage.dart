import 'package:flutter/material.dart';
import 'package:onlineexamplatform/src/exam/exampage.dart';

class StartPage extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<StartPage> {
  void exam() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ExamPage();
        },
      ),
    );

//    Navigator.of(context).pushReplacement(
//      MaterialPageRoute(
//        builder: (BuildContext context) {
//          return StudentHome("as");
//        },
//      ),
//    );
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
                  child: Text("1. There are 10 questions in this exam.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.orange))),
              Container(
                  alignment: Alignment.center,
                  child: Text(
                      "2. Do not close the app or go out of the app during the exam",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.orange))),
              Container(
                  alignment: Alignment.center,
                  child: Text("3. The question will come one after one.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.orange))),
              SizedBox(
                height: 50,
              ),
              submitbutton(),
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
        width: 200,
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
              'Next',
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
