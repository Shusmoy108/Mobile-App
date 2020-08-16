import 'package:flutter/material.dart';
import 'package:onlineexamplatform/src/login/loginpage.dart';


class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Master',
      debugShowCheckedModeBanner: false,

      home: LoginScreen(),
    );
  }
}
