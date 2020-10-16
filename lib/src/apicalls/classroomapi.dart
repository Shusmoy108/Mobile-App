import 'package:onlineexamplatform/src/models/classrooms.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ClassroomApi {

  String basUrl= 'https://4c852bf4-1d8f-4e81-818c-138a2a03c559.mock.pstmn.io/';

  Future<List<Classroom>> getClassrooms(String userid)async{
    var url = basUrl+"classrooms/12";
    var response = await http.get(url);
    var res = jsonDecode(response.body);
    bool success = res['success'];
    print(res);
    if(success){

      List<Classroom> classrooms= new List();
      for(var c in res['classrooms']){
        Classroom cr= new Classroom(c["_id"], c["roomName"], c["roomDescription"], c["roomExam"], c["roomCreator"]);
        classrooms.add(cr);
      }
      print(classrooms);
      return classrooms;
    }
    else{
      return null;
    }
  }

}