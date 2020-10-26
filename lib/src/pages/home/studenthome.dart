import 'dart:math';

import 'package:flutter/material.dart';
import 'package:onlineexamplatform/src/apicalls/classroomapi.dart';
import 'package:onlineexamplatform/src/apicalls/examapi.dart';
import 'package:onlineexamplatform/src/models/classrooms.dart';
import 'package:onlineexamplatform/src/models/exams.dart';
import 'package:onlineexamplatform/src/pages/achievement/achievement.dart';
import 'package:onlineexamplatform/src/pages/classroom/classroom.dart';
import 'package:onlineexamplatform/src/pages/exam/calender.dart';
import 'package:onlineexamplatform/src/pages/exam/exampage.dart';
import 'package:onlineexamplatform/src/pages/exam/startpage.dart';
import 'package:onlineexamplatform/src/pages/registration/initialpage.dart';
import 'package:onlineexamplatform/src/pages/settings/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class StudentHome extends StatefulWidget {
  StudentHome(this.classes, this.currentExams, this.previousExams);
  List<Classroom> classes;
  List<Exam> currentExams, previousExams;
  @override
  _StudentHomeState createState() =>
      _StudentHomeState(classes, currentExams, previousExams);
}

class _StudentHomeState extends State<StudentHome> {
  String mobile;
  List<Exam> currentExams, previousExams;
  _StudentHomeState(this.classes, this.currentExams, this.previousExams);
  List<Classroom> classes;
  int _selectedIndex = 0;
  var pages = [];
  ClassroomApi classroomApi = new ClassroomApi();
  ExamApi examApi = new ExamApi();
  @override
  void initState() {
    pages = [
      ClassroomPage(classes),
      Calender(currentExams, previousExams),
      //ExamlistPage(),
      AchievementPage(),
      SettingsPage()
    ];
  }

  void join() async {
    Navigator.of(context).pop();
    if (_selectedIndex == 0) {
      bool sc = await classroomApi.joinClasses(
          classCodecontroller.text, classCodecontroller.text);
      print(sc);
      classCodecontroller.clear();
      if (sc) {
        _scaffoldKey.currentState.showSnackBar(successClassSnackBar);
      } else {
        _scaffoldKey.currentState.showSnackBar(failedClassSnackBar);
      }
    } else if (_selectedIndex == 1) {
      Exam e = await examApi.joinExam(
          classCodecontroller.text, classCodecontroller.text);
      classCodecontroller.clear();
      if (e!=null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return StartPage(e);
            },
          ),
        );
      } else {
        _scaffoldKey.currentState.showSnackBar(failedClassSnackBar);
      }
    }
  }

  Widget snackbarButton() {
    String text;
    if (_selectedIndex == 0) {
      text = "Join Classroom";
    } else if (_selectedIndex == 1) {
      text = "Join Exam";
    }
    return InkWell(
      onTap: () {
        _showDialog();
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
              text,
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

  logout() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return InitialPage();
        },
      ),
    );
  }

  Widget logoutButton() {
    return InkWell(
      onTap: () {
        logout();
      },
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.red,
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
              'Logout',
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

  Widget joinButton() {
    return InkWell(
      onTap: () {
        join();
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
              'Join',
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

  TextEditingController classCodecontroller = new TextEditingController();

  // Widget floatButton() {
  //   if (_selectedIndex == 0) {
  //     return joinbutton();
  //   } else if (_selectedIndex == 3) {
  //     return logoutButton();
  //   }
  // }

  void _showDialog() {
    String title, label, hintText;
    if (_selectedIndex == 1) {
      title = "Join Exam";
      label = "Exam Code";
      hintText = "Please enter a Exam code";
    } else if (_selectedIndex == 0) {
      title = "Join Clasroom";
      label = "Clasroom Code";
      hintText = "Please enter a Classroom code";
    }
    final _formKey = GlobalKey<FormState>();
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                title: Text(title),
                content: Form(
                  key: _formKey,
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 5,
                    children: <Widget>[
                      TextFormField(
                        controller: classCodecontroller,
                        decoration: new InputDecoration(labelText: label),
                        validator: (value) {
                          if (value.isEmpty) {
                            return hintText;
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  joinButton(),
                ],
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var successClassSnackBar = SnackBar(
    content: Text("You have successfully joined the classroom"),
    backgroundColor: Colors.green,
    duration: Duration(seconds: 3),
  );
  var failedClassSnackBar = SnackBar(
    content: Text("There is some problem to join in the classroom"),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 3),
  );
  @override
  Widget build(BuildContext context) {
    var snackBar = SnackBar(
      content: snackbarButton(),
      //backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text("Quiz Master"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _scaffoldKey.currentState.showSnackBar(snackBar);
            },
          )
        ],
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.teal,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.class_),
            title: Text('Classroom'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('Calender'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stars),
            title: Text('Achievement'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
