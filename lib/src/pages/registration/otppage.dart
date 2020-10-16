import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlineexamplatform/src/pages/registration/registrationpage.dart';

class OTPPage extends StatefulWidget {
  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTPPage> {
  String one = "", two = "", three = "", four = "", otp = "", err = "";

  void OTP() {
    setState(() {
      otp = one + two + three + four;
    });
    print(otp);
    if (otp == "1234") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return RegisterForm();
          },
        ),
      );
    } else {
      err = "Incorrect OTP";
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
                  alignment: Alignment.center,
                  child: Text(
                      "An OTP is send to your mobile number. Please enter the OTP.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.orange))),
//                Container(
//                  height: MediaQuery.of(context).size.height/4.5,
//                  width: MediaQuery.of(context).size.width/2.5,
//                  decoration: BoxDecoration(
//                      image: DecorationImage(
//                        image: AssetImage('assets/TriggerTrackerIcons/splash_logo@3x.png'),
//                      )
//                  ),
//                ),
              SizedBox(
                height: 10,
              ),
              Container(
                  alignment: Alignment.center,
                  child: Text(err,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.redAccent))),
              SizedBox(
                height: 50,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Enter OTP:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.orange))),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  otpBoxBuilder(0),
                  SizedBox(
                    width: 5,
                  ),
                  otpBoxBuilder(1),
                  SizedBox(
                    width: 5,
                  ),
                  otpBoxBuilder(2),
                  SizedBox(
                    width: 5,
                  ),
                  otpBoxBuilder(3),
                ],
              ),
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
        OTP();
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
              'Submit',
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

  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }

  Widget otpBoxBuilder(int index) {
    return Container(
      alignment: Alignment.center,
      height: 70,
      width: 70,
      child: TextField(
        onChanged: (String value) {
          setState(() {
            if (index == 0) {
              one = value;
            } else if (index == 1) {
              two = value;
            } else if (index == 2) {
              three = value;
            } else if (index == 3) {
              four = value;
            }
          });
        },
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 23, color: Colors.blue),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(border: InputBorder.none, counterText: ''),
        textAlign: TextAlign.center,
      ),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.blue, width: 3)),
    );
  }
}
