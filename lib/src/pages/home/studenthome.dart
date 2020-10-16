import 'package:flutter/material.dart';
import 'package:onlineexamplatform/src/pages/achievement/achievement.dart';
import 'package:onlineexamplatform/src/pages/classroom/classroom.dart';
import 'package:onlineexamplatform/src/pages/exam/calender.dart';
import 'package:onlineexamplatform/src/pages/registration/initialpage.dart';
import 'package:onlineexamplatform/src/pages/settings/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class StudentHome extends StatefulWidget {
  String mobile;
  StudentHome(this.mobile);

  @override
  _StudentHomeState createState() => _StudentHomeState(mobile);
}

class _StudentHomeState extends State<StudentHome> {
  String mobile;
  _StudentHomeState(this.mobile);
  int _selectedIndex = 0;
  var pages = [
    ClassroomPage(),
    Calender(),
    //ExamlistPage(),
    AchievementPage(),
    SettingsPage()
  ];
  void joinexam() {
    classroom.add({"name": idcontroller.toString(), "teacher": "sakhawat"});
    Navigator.of(context).pop();
  }

  Widget joinbutton() {
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
              'Join Classroom',
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

  Widget joinexambutton() {
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

  TextEditingController idcontroller = new TextEditingController();

  Widget floatButton() {
    if (_selectedIndex == 0) {
      return joinbutton();
    } else if (_selectedIndex == 3) {
      return logoutButton();
    }
  }

  void _showDialog() {
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
                title: Text('Join Exam'),
                content: Form(
                  key: _formKey,
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 5,
                    children: <Widget>[
                      TextFormField(
                        controller: idcontroller,
                        decoration:
                            new InputDecoration(labelText: 'Classroom code'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a Classroom code';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog

                  joinexambutton(),
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  final snackBar = SnackBar(
    content: InkWell(
      onTap: () {
 // _showDialog();
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
'Join Classroom',
style: TextStyle(
color: Colors.white, fontSize: 20.0, fontFamily: 'Merienda'),
),
SizedBox(
width: 0.0,
),
],
),
),
),
    //backgroundColor: Colors.red,
    duration: Duration(seconds: 3),
  );
  var classroom = [
    {"name": "Physics", "teacher": "Prottoy"},
    {"name": "Math", "teacher": "Prottoy"},
    {"name": "Chemistry", "teacher": "Prottoy"},
    {"name": "Bangla", "teacher": "Prottoy"}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.teal,

            title: Text("Quiz Master"),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.add),onPressed: (){
                _scaffoldKey.currentState.showSnackBar(snackBar);
              },)
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
        floatingActionButton: floatButton());
  }
}
