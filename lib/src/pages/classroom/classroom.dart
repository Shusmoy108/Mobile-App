import 'package:flutter/material.dart';
import 'package:onlineexamplatform/src/models/classrooms.dart';
import 'package:onlineexamplatform/src/pages/classroom/classes.dart';

class ClassroomPage extends StatefulWidget {
  List<Classroom> classrooms;
  ClassroomPage(this.classrooms);
  @override
  _ClassroomState createState() => _ClassroomState(this.classrooms);
}

class _ClassroomState extends State<ClassroomPage> {
  List<Classroom> classrooms;
  _ClassroomState(this.classrooms);
  @override
  Widget classroom(int i, String classname, String teacher,String examNumber){
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
            trailing: Text(examNumber),
          ),
        ),
      ),
    );
  }
  Widget build(BuildContext context) {
    return Container(
      child:  new ListView.builder
        (
          itemCount: classrooms.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return  classroom(index+1,classrooms[index].roomName,classrooms[index].roomCreator,classrooms[index].roomExam);
          }
      )
    );
  }
}
