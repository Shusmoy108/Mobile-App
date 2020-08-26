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
    Navigator.of(context).pop();
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
        _showDialog();
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
  TextEditingController linkcontroller = new TextEditingController();
  TextEditingController idcontroller = new TextEditingController();
  bool link=true;
  String text="Enter Exam ID";
  void _toogle(){

    setState(() {
      if(link){
        text="Enter Exam Link";
        link=false;
      }
      else{
        text="Enter Exam ID";
        link=true;
      }

    });
    Navigator.of(context).pop();
    _showDialog();
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
                      Visibility(
                        visible: !link,
                        child: TextFormField(
                          controller: idcontroller,
                          //keyboardType: TextInputType.number,
//                          inputFormatters: <TextInputFormatter>[
//                            WhitelistingTextInputFormatter.digitsOnly
//                          ],
                          decoration:
                          new InputDecoration(labelText: 'Exam ID'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a Exam id';
                            }
                            return null;
                          },
                        ),
                      ),
                      Visibility(
                        visible: link,
                        child: TextFormField(
                          controller: linkcontroller,
                          decoration: new InputDecoration(
                              labelText: 'Exam Link',
                              hintText: 'eg. https://www.google.com/'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a Exam Link';
                            }
                            return null;
                          },
                        ),
                      )
                      ,
                    ],
                  ),
                ),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text(text),
                    onPressed: () async {
                      _toogle();
                    },
                  ),
                  new FlatButton(
                    child: new Text("Join"),
                    onPressed: () async {
                      joinexam();
                      if (_formKey.currentState.validate()) {

                      }
                    },
                  ),
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
