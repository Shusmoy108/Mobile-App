import 'package:flutter/material.dart';
import 'package:onlineexamplatform/src/exam/exampage.dart';
import 'package:onlineexamplatform/src/exam/startpage.dart';

class ExamlistPage extends StatefulWidget {
  @override
  _ExamlistState createState() => _ExamlistState();
}

class _ExamlistState extends State<ExamlistPage> {
  List<String> items = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
    "Item 6",
    "Item 7",
    "Item 8"
  ];
  Widget currentexam(int i, String classname, String teacher) {
    teacher = "conducted by " + teacher;
    return Center(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: ListTile(
            leading: Text(
              i.toString(),
              style: TextStyle(fontSize: 20),
            ),
            title: Text(classname),
            subtitle: Text(teacher),
            trailing: startbutton(),
          ),
        ),
      ),
    );
  }

  Widget previousExam(int i, String classname, String teacher) {
    teacher = "conducted by " + teacher;
    return Center(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: ListTile(
            leading: Text(
              i.toString(),
              style: TextStyle(fontSize: 20),
            ),
            title: Text(classname),
            subtitle: Text(teacher),
          ),
        ),
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final headerList = new ListView.builder(itemBuilder: (context, index) {
      return currentexam(index + 1, "Chemistry", "Sakhawat");
    });

    final body = new Container(
      color: Colors.white,
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
                  alignment: Alignment.center,
                  child: new Padding(
                      padding: new EdgeInsets.only(left: 8.0),
                      child: new Text(
                        'Current Exams',
                        style: new TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                new Divider(),
                new Container(height: 300.0, width: _width, child: headerList),
                new Align(
                  alignment: Alignment.center,
                  child: new Padding(
                      padding: new EdgeInsets.only(top: 8.0),
                      child: new Text(
                        'Previous Exams',
                        style: new TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                new Divider(),
                new Expanded(
                    child: ListView.builder(itemBuilder: (context, index) {
                  return previousExam(index + 1, "Physics", "Prottoy");
                }))
              ],
            ),
          ),
        ],
      ),
    );

    return new Container(
      decoration: new BoxDecoration(
        color: const Color(0xFF273A48),
      ),
      child: new Stack(
        children: <Widget>[
          new CustomPaint(
            size: new Size(_width, _height),
            //painter: new Background(),
          ),
          body,
        ],
      ),
    );
  }
}
