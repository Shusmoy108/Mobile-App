import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlineexamplatform/src/pages/exam/answerscript.dart';
import 'package:onlineexamplatform/src/pages/exam/exampage.dart';
import 'package:onlineexamplatform/src/pages/exam/resultpage.dart';
import 'package:onlineexamplatform/src/pages/exam/startpage.dart';

class Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
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
        width: 100,
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

  Widget OngoingExam(int index, String examname, String teacher) {
    EdgeInsets padding = index == 0
        ? const EdgeInsets.only(left: 20.0, right: 10.0, top: 4.0, bottom: 30.0)
        : const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 4.0, bottom: 30.0);
    teacher = "conducted by " + teacher;
    return new Padding(
      padding: padding,
      child: new InkWell(
        onTap: () {
          print('Card selected');
        },
        child: new Container(
          padding: EdgeInsets.only(bottom: 10, top: 10),
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(10.0),
            color: Colors.blueGrey,
            boxShadow: [
              new BoxShadow(
                  color: Colors.black.withAlpha(70),
                  offset: const Offset(3.0, 10.0),
                  blurRadius: 15.0)
            ],
          ),
          //height: 100.0,
          width: 200.0,
          child: new Stack(
            children: <Widget>[
              Center(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      examname,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontFamily: 'Merienda'),
                    ),
                    //SizedBox(height: 5,),
                    Text(
                      teacher,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontFamily: 'Merienda'),
                    ),
                    Text(
                      "09/12/2020",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontFamily: 'Merienda'),
                    ),
                    Text(
                      "9.00 am - 12.00 pm",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontFamily: 'Merienda'),
                    ),
                    //Divider(),
                  ],
                ),
              ),
              new Align(
                alignment: Alignment.bottomCenter,
                child: startbutton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    final headerList = new ListView.builder(
      itemBuilder: (context, index) {
        return OngoingExam(index, "Physics", "Prottoy");
      },
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
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
                new Container(height: 200.0, width: _width, child: headerList),
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
                    child: ListView.builder(itemBuilder: (context, index) {
                  return previousexam(index, "Chemistry-01", "Sakhawat", true);
                }))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
