import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onlineexamplatform/src/apicalls/classroomapi.dart';
import 'package:onlineexamplatform/src/models/classrooms.dart';
import 'package:onlineexamplatform/src/models/exams.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onlineexamplatform/src/pages/home/studenthome.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String mobileNumber, password, name;
  bool passFlag = false, nameFlag = true, nextFlag = true;
  bool _autovalidateLoginform = false, _shouldObscureText = true;
  final loginFormKey = GlobalKey<FormState>();
  saveAuthData(bool value, String mobile) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('auth', value);
    sp.setString("mobile", mobile);
  }

  void login() async {
    saveAuthData(true, mobileNumber);
    ClassroomApi classroomApi = new ClassroomApi();
    List<Classroom> classrooms = await classroomApi.getClassrooms("userid");
    var exams = await classroomApi.getClassroomExams("asdsad");
//    if(res!=null){
    //var exams = jsonDecode(res);
    List<Exam> currentExams = new List();
    for (var e in exams['currentExam']) {
      Exam er = new Exam(e["_id"], e["examName"], e["examInstruction"],
          e["examSubject"], e["examCreator"], e["examTime"], e["examMarks"]);
      er.examStart = e["examStart"];
      er.examDuration = e["examDuration"];
      currentExams.add(er);
    }
    List<Exam> previousExams = new List();
    for (var e in exams['previousExam']) {
      Exam er = new Exam(e["_id"], e["examName"], e["examInstruction"],
          e["examSubject"], e["examCreator"], e["examTime"], e["examMarks"]);
      er.examAnswerAvailable = e["examAnswerAvailable"];
      er.examDuration = e["examDuration"];
      previousExams.add(er);
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return StudentHome(classrooms, currentExams, previousExams);
        },
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
            child: Form(
              key: loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Visibility(
                    visible: nameFlag,
                    child: nameField(),
                  ),
                  Visibility(
                    visible: passFlag,
                    child: passwordField(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: nextFlag,
                    child: nextbutton(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void toggleObscureFlag() {
    setState(() {
      _shouldObscureText = !_shouldObscureText;
    });
  }

  Widget nextbutton() {
    return InkWell(
      onTap: () {
        //print(loginFormKey.currentState.validate());
        if (loginFormKey.currentState.validate() && nameFlag) {
          setState(() {
            nameFlag = false;
            passFlag = true;
          });
        } else if (loginFormKey.currentState.validate() && passFlag) {
          login();
        }
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
              'Next',
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

  Widget passwordField() {
    return Container(
        width: 350,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Password *',
            labelStyle: TextStyle(
              color: Colors.black87,
            ),
            icon: Icon(
              Icons.lock,
              color: Colors.black87,
            ),
            suffix: GestureDetector(
              onTap: toggleObscureFlag,
              child: _shouldObscureText
                  ? Icon(FontAwesomeIcons.solidEye)
                  : Icon(FontAwesomeIcons.solidEyeSlash),
            ),
          ),
          obscureText: _shouldObscureText,
          validator: (String value) {
            if (value.length > 5)
              return null;
            else
              return 'Password is required and minimum length is six';
          },
          onChanged: (String value) {
            setState(() {
              password = value;
            });
          },
        ));
  }

  Widget nameField() {
    return Container(
        width: 350,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Full Name *',
            hintText: 'John Dee',
            icon: Icon(
              Icons.person,
              color: Colors.black87,
            ),
            labelStyle: TextStyle(
              color: Colors.black87,
            ),
          ),
          autovalidate: _autovalidateLoginform,
          validator: (String value) {
            if (value.length > 1)
              return null;
            else
              return 'Full name is required.';
          },
          onChanged: (String value) {
            setState(() {
              name = value;
            });
          },
        ));
  }
}
