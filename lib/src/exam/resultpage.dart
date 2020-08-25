import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:onlineexamplatform/src/exam/exampage.dart';
import 'package:onlineexamplatform/src/home/studenthome.dart';
import 'package:onlineexamplatform/src/registration/registrationpage.dart';
class ResultPage extends StatefulWidget {


  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<ResultPage> {


  void exam() {

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return StudentHome("");
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
      body:SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  child: Text("Thank You for attending the exam.", style:TextStyle(fontWeight:FontWeight.bold, fontSize: 25, color: Colors.orange))
              ),
SizedBox(height: 25,),
              Container(
                  alignment: Alignment.center,
                  child: Text("Your result will be given soon.", style:TextStyle(fontWeight:FontWeight.bold, fontSize: 25, color: Colors.orange))
              ),
              SizedBox(height: 25,),
              Container(
                  alignment: Alignment.center,
                  child: Text("You will be notified about your result through sms.", style:TextStyle(fontWeight:FontWeight.bold, fontSize: 25, color: Colors.orange))
              ),

              SizedBox(height: 50,),
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
              'Home',
              style: TextStyle(
                  color: Colors.white, fontSize: 20.0),
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