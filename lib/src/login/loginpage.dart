import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:onlineexamplatform/src/home/studenthome.dart';
import 'package:onlineexamplatform/src/home/teacherhome.dart';
import 'package:onlineexamplatform/src/registration/registrationpage.dart';

const users = const {
  '01819648302': '12345',
  'hunter@gmail.com': 'hunter',
};
class LoginScreen extends StatefulWidget {
  @override
  LoginScreenForm createState() => LoginScreenForm();
}

class LoginScreenForm extends State<LoginScreen> {

  String password="",mobile="";
  int x=-1;
  @override
  Future signup(context){
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => Scaffold(),

          //RegisterForm(),
    ));
  }
  Future login(context){
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => Scaffold(),
    ));
  }
  Duration get loginTime => Duration(milliseconds: 2250);
  Future<String> _signup(LoginData data) {
    setState(() {
  mobile=data.name;
  password=data.password;
  x=0;
  });
  print('Name: ${data.name}, Password: ${data.password}');
  return Future.delayed(loginTime).then((_) {
//      if (!users.containsKey(data.name)) {
//        return 'Username not exists';
//      }
//      if (users[data.name] != data.password) {
//        return 'Password does not match';
//      }
  return null;
  });
}
  Future<String> _login(LoginData data) {
    setState(() {
      mobile=data.name;
      password=data.password;
      x=1;
    });
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Mobile number does not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }
  String emailValidator(String value){
    if(value.length<8){
      return "Invalid mobile number";
    }
  }
  Widget build(BuildContext context) {
    final inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return FlutterLogin(
      title: 'Quiz Master',
      //logo: 'images/logo.jpg',
      onLogin: _login,
      onSignup: _signup,
      emailValidator: emailValidator,
      onSubmitAnimationCompleted: () {
        if(x==0){
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => RegisterForm(mobile,password),
        ));}
        if(x==1){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => StudentHome(mobile),
          ));
        }
      },
      onRecoverPassword: (_) => Future(null),
      messages: LoginMessages(
        usernameHint: 'Mobile Number',
        passwordHint: 'Password',
        confirmPasswordHint: 'Confirm',
        loginButton: 'LOG IN',
        signupButton: 'Create a new Account',
        forgotPasswordButton: 'Forgot Your Password',
        recoverPasswordButton: 'HELP ME',
        goBackButton: 'GO BACK',
        confirmPasswordError: 'Not match!',
        recoverPasswordDescription:
        'Please the mobile number of your account. We will send an OTP to your number for password change request.',
        recoverPasswordSuccess: 'Password rescued successfully',
      ),
      theme: LoginTheme(
        primaryColor: Colors.teal,
        accentColor: Colors.yellow,
        errorColor: Colors.deepOrange,
        titleStyle: TextStyle(
          color: Colors.greenAccent,
          fontFamily: 'Quicksand',
          letterSpacing: 4,
        ),
        bodyStyle: TextStyle(
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
        textFieldStyle: TextStyle(
          color: Colors.orange,
          shadows: [Shadow(color: Colors.yellow, blurRadius: 2)],
        ),
        buttonStyle: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.yellow,
        ),
        cardTheme: CardTheme(
          color: Colors.yellow.shade100,
          elevation: 5,
          margin: EdgeInsets.only(top: 15),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
        ),
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.purple.withOpacity(.1),
          contentPadding: EdgeInsets.zero,
          errorStyle: TextStyle(
            backgroundColor: Colors.orange,
            color: Colors.white,
          ),
          labelStyle: TextStyle(fontSize: 12),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
            borderRadius: inputBorder,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
            borderRadius: inputBorder,
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 7),
            borderRadius: inputBorder,
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade400, width: 8),
            borderRadius: inputBorder,
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 5),
            borderRadius: inputBorder,
          ),
        ),
//        buttonTheme: LoginButtonTheme(
//          splashColor: Colors.purple,
//          backgroundColor: Colors.pinkAccent,
//          highlightColor: Colors.lightGreen,
//          elevation: 9.0,
//          highlightElevation: 6.0,
//          shape: BeveledRectangleBorder(
//            borderRadius: BorderRadius.circular(10),
//          ),
//          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//          // shape: CircleBorder(side: BorderSide(color: Colors.green)),
//          // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
//        ),
      ),



    );
  }
}