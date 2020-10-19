import 'package:onlineexamplatform/src/models/classrooms.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ClassroomApi {

  String basUrl= 'https://e7bc560a-3c7a-462e-b228-623801a87edc.mock.pstmn.io';

  Future<List<Classroom>> getClassrooms(String userid)async{
    var url = basUrl+"/classrooms/showclasses/"+userid;
    var response = await http.get(url);
    var res = jsonDecode(response.body);
    bool success = res['success'];
    if(success){
      List<Classroom> classrooms= new List();
      for(var c in res['classrooms']){
        Classroom cr= new Classroom(c["_id"], c["roomName"], c["roomDescription"], c["roomExam"], c["roomCreator"]);
        classrooms.add(cr);
      }
      return classrooms;
    }
    else{
      return null;
    }
  }
  Future<bool> joinClasses(String classCode, String classLink)async{
    var url = basUrl+"classrooms/joinclasses";
    var response = await http.get(url);
    var res = jsonDecode(response.body);
    bool success = res['success'];

      return success;

  }

}