import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlineexamplatform/src/apicalls/examapi.dart';
import 'package:onlineexamplatform/src/models/answerscript.dart';
import 'package:onlineexamplatform/src/models/exams.dart';
import 'package:onlineexamplatform/src/pages/exam/resultpage.dart';

import 'package:onlineexamplatform/src/pages/exam/timer.dart';

class ExamPage extends StatefulWidget {
  Exam e;
  AnswerScript answerScript;
  ExamPage(this.e,this.answerScript);
  @override
  _ExamState createState() => _ExamState(e,answerScript);
}

class _ExamState extends State<ExamPage> {
  Exam e;
  AnswerScript answerScript;
  _ExamState(this.e,this.answerScript);
  int examnumber = 0;
  @override
  void initState() {
    setState(() {
      for (int i = 0; i < e.examQuestions.length; i++) {
        te[i] = new TextEditingController();
        answerScript.examScript[i].answer = "Not Answered";
      }
    });
  }

  List<TextEditingController> te = new List(10);
  Widget MCQ(String question, var options, int index) {
    List<Widget> widgets = [];
    for (var option in options) {
      widgets.add(
        RadioListTile(
          value: option,
          groupValue: answerScript.examScript[index].answer,
          title: Text(option),
          onChanged: (value) {
            setState(() {
              answerScript.examScript[index].answer = value;
            });
          },
          selected: answerScript.examScript[index].answer == option,
          activeColor: Colors.green,
        ),
      );
    }
    return Container(
      child: Column(
        children: <Widget>[
          Text(question,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.orange)),
          Column(
            children: widgets,
          )
        ],
      ),
    );
  }

  Widget Gap(String question, int index) {
    //te[index]=new TextEditingController();
    return Container(
      child: Column(
        children: <Widget>[
          Text(question,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.orange)),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: te[index],
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
              //fillColor: Colors.green

              labelText: 'Answer',
              // hintText: 'John Dee',
              icon: Icon(
                Icons.description,
                color: Colors.black87,
              ),

              labelStyle: TextStyle(
                color: Colors.black87,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget YesNo(String question, int index) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(question,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.orange)),
          Column(
            children: <Widget>[
              RadioListTile(
                value: "Yes",
                groupValue:answerScript.examScript[index].answer,
                title: Text("Yes"),
                onChanged: (value) {
                  setState(() {
                    answerScript.examScript[index].answer = value;
                  });
                },
                selected:answerScript.examScript[index].answer == "Yes",
                activeColor: Colors.green,
              ),
              RadioListTile(
                value: "No",
                groupValue: answerScript.examScript[index].answer,
                title: Text("No"),
                onChanged: (value) {
                  setState(() {
                    answerScript.examScript[index].answer = value;
                  });
                },
                selected: answerScript.examScript[index].answer == "No",
                activeColor: Colors.green,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget TrueFalse(String question, int index) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(question,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.orange)),
          Column(
            children: <Widget>[
              RadioListTile(
                value: "True",
                groupValue: answerScript.examScript[index].answer,
                title: Text("True"),
                onChanged: (value) {
                  setState(() {
                    answerScript.examScript[index].answer = value;
                  });
                },
                selected:answerScript.examScript[index].answer == "True",
                activeColor: Colors.green,
              ),
              RadioListTile(
                value: "False",
                groupValue: answerScript.examScript[index].answer,
                title: Text("False"),
                onChanged: (value) {
                  setState(() {
                    answerScript.examScript[index].answer= value;
                  });
                },
                selected: answerScript.examScript[index].answer == "False",
                activeColor: Colors.green,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget Multipleanswer(String question, var options, int index) {
    List<Widget> widgets = [];
    for (var option in options) {
      widgets.add(
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          value: answerScript.examScript[index].answer != null &&
              answerScript.examScript[index].answer.split(",").contains(option),
          title: Text(option),
          onChanged: (value) {
            setState(() {
              if (value) {
                if (answerScript.examScript[index].answer == null|| answerScript.examScript[index].answer=="Not Answered") {
                  answerScript.examScript[index].answer = option;
                } else {
                  answerScript.examScript[index].answer =answerScript.examScript[index].answer + "," + option;
                }
              } else {
                var str = answerScript.examScript[index].answer.split(",");
                if (str.contains(option)) {
                  str.remove(option);
                }
                answerScript.examScript[index].answer = str[0];
                for (int i = 1; i < str.length; i++) {
                  answerScript.examScript[index].answer= answerScript.examScript[index].answer + "," + str[i];
                }
              }
            });
          },
          selected:answerScript.examScript[index].answer == option,
          activeColor: Colors.green,
        ),
      );
    }
    return Container(
      child: Column(
        children: <Widget>[
          Text(question,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.orange)),
          Column(
            children: widgets,
          )
        ],
      ),
    );
  }

  Widget getExamWidget(int i) {
    if (e.examQuestions[i].questionType == "MCQ") {
      return MCQ(e.examQuestions[i].question, e.examQuestions[i].options, i);
    } else if (e.examQuestions[i].questionType == 'Multipleanswer') {
      return Multipleanswer(
          e.examQuestions[i].question, e.examQuestions[i].options, i);
    } else if (e.examQuestions[i].questionType == 'gap' ||
        e.examQuestions[i].questionType == 'Explain' ||
        e.examQuestions[i].questionType == 'Q/A') {
      return Gap(e.examQuestions[i].question, i);
    } else if (e.examQuestions[i].questionType == 'T/F') {
      return TrueFalse(e.examQuestions[i].question, i);
    } else if (e.examQuestions[i].questionType == 'Y/N') {
      return YesNo(e.examQuestions[i].question, i);
    }
  }

  Widget buttons() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Visibility(
            visible: examnumber > 0,
            child: prevbutton(),
          ),
          Visibility(
            visible: examnumber == (e.examQuestions.length - 1),
            child: submitbutton(),
          ),
          Visibility(
            visible: (examnumber < e.examQuestions.length &&
                examnumber != e.examQuestions.length - 1),
            child: nextbutton(),
          ),
        ],
      ),
    );
  }

  Widget nextbutton() {
    return InkWell(
      onTap: () {
        setState(() {
          if (e.examQuestions[examnumber].questionType == 'gap' ||
              e.examQuestions[examnumber].questionType == 'Explain' ||
              e.examQuestions[examnumber].questionType == 'Q/A') {
            answerScript.examScript[examnumber].answer = te[examnumber].text;
          }
          examnumber++;
        });
        //login();
      },
      child: Container(
        width: 100,
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

  Widget prevbutton() {
    return InkWell(
      onTap: () {
        setState(() {
          if (e.examQuestions[examnumber].questionType == 'gap' ||
              e.examQuestions[examnumber].questionType == 'Explain' ||
              e.examQuestions[examnumber].questionType == 'Q/A') {
            answerScript.examScript[examnumber].answer = te[examnumber].text;
          }
          examnumber--;
        });
      },
      child: Container(
        width: 100,
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
              'Previous',
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

  void result() async {
    ExamApi examApi = new ExamApi();
    bool success= await examApi.submitAnswerscript(answerScript);
    print(success);
    if(success) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return ResultPage();
          },
        ),
      );
    }
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
                //width: 100.0,
                padding: EdgeInsets.only(top: 3.0, right: 4.0),
                child: CountDownTimer(
                  secondsRemaining: e.examDuration,
                  whenTimeExpires: result,
                  countDownTimerStyle: TextStyle(
                      color: Color(0XFFf5a623), fontSize: 17.0, height: 1.2),
                ),
              ),
              getExamWidget(examnumber),
              SizedBox(
                height: 50,
              ),
              buttons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget submitbutton() {
    return InkWell(
      onTap: () {
        result();
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
              'Submit',
              style: TextStyle(color: Colors.white, fontSize: 15.0),
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
