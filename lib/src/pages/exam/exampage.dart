import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlineexamplatform/src/pages/exam/resultpage.dart';

import 'package:onlineexamplatform/src/pages/exam/timer.dart';

class ExamPage extends StatefulWidget {
  @override
  _ExamState createState() => _ExamState();
}

class _ExamState extends State<ExamPage> {
  int examnumber = 0;
  var exam = [
    {"type": 'Q/A', "question": "What is your name?"},
    {"type": 'Explain', "question": "Explain the exam?"},
    {"type": 'Y/N', "question": "Are you a man?"},
    {"type": 'T/F', "question": "You are a man"},
    {"type": 'gap', "question": "I am a _______"},
    {
      "type": 'MCQ',
      "question": "2+2 = ?",
      "options": ["1", "2", "3", "4"]
    },
    {
      "type": 'Multipleanswer',
      "question": "2+2 = ?",
      "options": ["1", "2", "3", "4"]
    }
  ];
  List<String> answers = new List(10);
  @override
  void initState() {
    setState(() {
      for (int i = 0; i < 10; i++) {
        te[i] = new TextEditingController();
        answers[i] = "Not Answered";
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
          groupValue: answers[index],
          title: Text(option),
          onChanged: (value) {
            setState(() {
              answers[index] = value;
            });
          },
          selected: answers[index] == option,
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
                groupValue: answers[index],
                title: Text("Yes"),
                onChanged: (value) {
                  setState(() {
                    answers[index] = value;
                  });
                },
                selected: answers[index] == "Yes",
                activeColor: Colors.green,
              ),
              RadioListTile(
                value: "No",
                groupValue: answers[index],
                title: Text("No"),
                onChanged: (value) {
                  setState(() {
                    answers[index] = value;
                  });
                },
                selected: answers[index] == "No",
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
                groupValue: answers[index],
                title: Text("True"),
                onChanged: (value) {
                  setState(() {
                    answers[index] = value;
                  });
                },
                selected: answers[index] == "True",
                activeColor: Colors.green,
              ),
              RadioListTile(
                value: "False",
                groupValue: answers[index],
                title: Text("False"),
                onChanged: (value) {
                  setState(() {
                    answers[index] = value;
                  });
                },
                selected: answers[index] == "False",
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
          value: answers[index] != null &&
              answers[index].split(",").contains(option),
          title: Text(option),
          onChanged: (value) {
            setState(() {
              if (value) {
                if (answers[index] == null) {
                  answers[index] = option;
                } else {
                  answers[index] = answers[index] + "," + option;
                }
              } else {
                var str = answers[index].split(",");
                if (str.contains(option)) {
                  str.remove(option);
                }
                answers[index] = str[0];
                for (int i = 1; i < str.length; i++) {
                  answers[index] = answers[index] + "," + str[i];
                }
              }
            });
          },
          selected: answers[index] == option,
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
    if (exam[i]['type'] == "MCQ") {
      return MCQ(exam[i]["question"], exam[i]["options"], i);
    } else if (exam[i]['type'] == 'Multipleanswer') {
      return Multipleanswer(exam[i]["question"], exam[i]["options"], i);
    } else if (exam[i]['type'] == 'gap' ||
        exam[i]['type'] == 'Explain' ||
        exam[i]['type'] == 'Q/A') {
      return Gap(exam[i]["question"], i);
    } else if (exam[i]['type'] == 'T/F') {
      return TrueFalse(exam[i]["question"], i);
    } else if (exam[i]['type'] == 'Y/N') {
      return YesNo(exam[i]["question"], i);
    }
  }

  Widget buttons() {
    return Container(
      child: Row(
        children: <Widget>[
          Visibility(
            visible: examnumber > 0,
            child: prevbutton(),
          ),
          SizedBox(
            width: 10,
          ),
          Visibility(
            visible: examnumber == (exam.length - 1),
            child: submitbutton(),
          ),
          SizedBox(
            width: 10,
          ),
          Visibility(
            visible:
                examnumber < exam.length && examnumber != (exam.length - 1),
            child: nextbutton(),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }

  Widget nextbutton() {
    return InkWell(
      onTap: () {
        setState(() {
          if (exam[examnumber]['type'] == 'gap' ||
              exam[examnumber]['type'] == 'Explain' ||
              exam[examnumber]['type'] == 'Q/A') {
            answers[examnumber] = te[examnumber].text;
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
          if (exam[examnumber]['type'] == 'gap' ||
              exam[examnumber]['type'] == 'Explain' ||
              exam[examnumber]['type'] == 'Q/A') {
            answers[examnumber] = te[examnumber].text;
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

  void result() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ResultPage(answers);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                //width: 100.0,
                padding: EdgeInsets.only(top: 3.0, right: 4.0),
                child: CountDownTimer(
                  secondsRemaining: 30,
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
