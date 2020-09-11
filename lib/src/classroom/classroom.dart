import 'package:flutter/material.dart';
import 'package:onlineexamplatform/src/classroom/classes.dart';
import 'package:onlineexamplatform/src/exam/exampage.dart';

class ClassroomPage extends StatefulWidget {
  @override
  _ClassroomState createState() => _ClassroomState();
}

class _ClassroomState extends State<ClassroomPage> {
  @override
  Widget classroom(int i, String classname, String teacher){
    teacher= "conducted by "+teacher;
    return Center(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return Classes(classname);
                },
              ),
            );
          },
          child: ListTile(
            leading: Text(i.toString(),style: TextStyle(fontSize: 20),),
            title: Text(classname),
            subtitle: Text(teacher),
          ),
        ),
      ),
    );
  }
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          classroom(1,"Chemistry","Prottoy"),
          classroom(2,"Physics","Prottoy"),
          classroom(3,"Mathematics","Prottoy"),
        ],
      ),
    );
  }
}