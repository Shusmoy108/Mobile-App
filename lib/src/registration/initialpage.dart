import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:onlineexamplatform/src/home/studenthome.dart';
import 'package:onlineexamplatform/src/registration/otppage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialFormState createState() => _InitialFormState();
}

class _InitialFormState extends State<InitialPage> {
  String mobileNumber, password, err = "";
  bool mobileFlag = true, passFlag = false, nameFlag = false, nextFlag = true;
  bool _autovalidateLoginform = false, _shouldObscureText = true;
  final loginFormKey = GlobalKey<FormState>();
  saveAuthData(bool value, String mobile) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('auth', value);
    sp.setString("mobile", mobile);
  }

  void login() {
    print(password);
    print(mobileNumber);
    if (mobileNumber == "01819648302" && password == "123456") {
      saveAuthData(true, mobileNumber);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return StudentHome(mobileNumber);
          },
        ),
      );
    } else {
      setState(() {
        err = "Wrong Password";
      });
    }
  }

  void mobileCheck() {
    if (mobileNumber == "01819648302") {
      setState(() {
        mobileFlag = false;
        passFlag = true;
        nextFlag = false;
      });
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return OTPPage();
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
        body: Container(
          child: Center(
            child: Form(
              key: loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: Text(err,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.redAccent))),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: mobileFlag,
                    child: mobileField(),
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
                  Visibility(
                    visible: !nextFlag,
                    child: loginbutton(),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  bool isNumeric(String str) {
    try {
      var value = double.parse(str);
    } on FormatException {
      return false;
    } finally {
      return true;
    }
  }

  void toggleObscureFlag() {
    setState(() {
      _shouldObscureText = !_shouldObscureText;
    });
  }

  Widget nextbutton() {
    return InkWell(
      onTap: () {
        if (loginFormKey.currentState.validate()) {
          mobileCheck();
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

  Widget loginbutton() {
    return InkWell(
      onTap: () {
        login();
      },
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          color: Color.fromRGBO(220, 20, 60, 0.8),
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
              'Login',
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
    return TextFormField(
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
        if (value.length > 6)
          return null;
        else
          return 'Password is required and minimum length is six';
      },
      onChanged: (String value) {
        setState(() {
          password = value;
        });
      },
    );
  }

  Widget mobileField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Mobile Number *',
        hintText: '01810000003',
        icon: Icon(
          Icons.phone,
          color: Colors.black87,
        ),
        labelStyle: TextStyle(
          color: Colors.black87,
        ),
      ),
      keyboardType: TextInputType.number,
      autovalidate: _autovalidateLoginform,
      validator: (String value) {
        if (isNumeric(value) && value.length == 11)
          return null;
        else
          return 'Mobile number is invalid';
      },
      onChanged: (String value) {
        setState(() {
          mobileNumber = value;
        });
      },
    );
  }
}
