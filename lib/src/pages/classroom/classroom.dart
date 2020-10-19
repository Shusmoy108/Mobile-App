import 'package:flutter/material.dart';
import 'package:onlineexamplatform/src/apicalls/classroomapi.dart';
import 'package:onlineexamplatform/src/models/classrooms.dart';
import 'package:onlineexamplatform/src/pages/classroom/classes.dart';

class ClassroomPage extends StatefulWidget {
  ClassroomPage(this.classrooms);
  List<Classroom> classrooms;
  @override
  _ClassroomState createState() => _ClassroomState(classrooms);
}

class _ClassroomState extends State<ClassroomPage> {
  List<Classroom> classrooms;
  _ClassroomState(this.classrooms);
  Future<List<Classroom>> getClasses() async {
//    ClassroomApi classroomApi= new ClassroomApi();
//    List<Classroom>  classes=  await classroomApi.getClassrooms("12");
//    setState(() {
//      classrooms=classes;
//    });
    return classrooms;
  }
  @override
  Widget classroom(int i, String classname,String description, String teacher,String examNumber){
    teacher= "conducted by "+teacher;
    return InkWell(
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
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, spreadRadius: 1),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(classname,style: TextStyle(
             fontSize: 20.0, fontFamily: 'Merienda'),
        ),
                Text(description,style: TextStyle(
                     fontSize: 15.0, fontFamily: 'Merienda'),
                ),
                Text(teacher,style: TextStyle(
                     fontSize: 15.0, fontFamily: 'Merienda'),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(examNumber,style: TextStyle(
                    fontSize: 15.0, fontFamily: 'Merienda'),
                ),
                Text("Exams",style: TextStyle(
                    fontSize: 15.0, fontFamily: 'Merienda'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getClasses(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length>0) {
              return  new ListView.builder
                (
                  itemCount: classrooms.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return  classroom(index+1,classrooms[index].roomName,classrooms[index].roomDescription,classrooms[index].roomCreator,classrooms[index].roomExam);
                  }
              );
            } else {
              return Text("You are not joined to any classroom");
            }
          } else {
            return Text("Network Problem");
          }
        },
      ),

    );
  }
}
