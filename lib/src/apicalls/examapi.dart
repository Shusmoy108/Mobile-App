import 'package:http/http.dart' as http;
import 'package:onlineexamplatform/src/models/answerscript.dart';
import 'package:onlineexamplatform/src/models/exams.dart';
import 'dart:convert';

import 'package:onlineexamplatform/src/models/questions.dart';

class ExamApi {
  String basUrl = 'https://e7bc560a-3c7a-462e-b228-623801a87edc.mock.pstmn.io';
  Future getExams(String userId) async {
    var url = basUrl + "/exams/" + userId;
    var response = await http.get(url);
    var res = jsonDecode(response.body);
    bool success = res['success'];
    if (success) {
      return {
        "currentExam": res['currentExams'],
        "previousExam": res["previousExams"]
      };
    } else {
      return {"currentExam": [], "previousExam": []};
    }
  }

  Future<Exam> joinExam(String examCode, String classLink) async {
    var url = basUrl + "/exams/joinExam";
    var response = await http.post(url, body: {examCode: examCode});
    var res = jsonDecode(response.body);
    bool success = res['success'];
    if(success){
      Exam e = new Exam(res["exam"]["examId"], res["exam"]["examName"], res["exam"]["examInstruction"], res["exam"]["examSubject"], res["exam"]["examCreator"], res["exam"]["examTime"], res["exam"]["examMarks"]);
      e.examDuration=res["exam"]["examDuration"];
      List<Question> questions = new List();
      for (var c in res["exam"]['examQuestions']) {
        Question cr = new Question(
            c["_id"], c["questionType"], c["question"], c["answer"]);
        if (cr.questionType == "MCQ" || cr.questionType == "Multipleanswer") {
          cr.options = c["options"].cast<String>();
        }
        questions.add(cr);
      }
      e.examQuestions=questions;
      print(e.examQuestions.length);
      return e;
    }
    return null;
  }

  Future<List<Question>> getQuestions(String examId) async {
    var url = basUrl + "/exams/questions/" + examId;
    var response = await http.get(url);
    var res = jsonDecode(response.body);
    bool success = res['success'];
    if (success) {
      List<Question> questions = new List();
      for (var c in res['examQuestions']) {
        Question cr = new Question(
            c["_id"], c["questionType"], c["question"], "");
        if (cr.questionType == "MCQ" || cr.questionType == "Multipleanswer") {
          cr.options = c["options"].cast<String>();
        }
        questions.add(cr);
      }
      return questions;
    } else {
      return [];
    }
  }
  Future<List<Question>> getAnswers(String examId) async {
    var url = basUrl + "/exams/answers/" + examId;
    var response = await http.get(url);
    var res = jsonDecode(response.body);
    bool success = res['success'];
    if (success) {
      List<Question> questions = new List();
      for (var c in res['examQuestions']) {
        Question cr = new Question(
            c["_id"], c["questionType"], c["question"], c["answer"]);
        if (cr.questionType == "MCQ" || cr.questionType == "Multipleanswer") {
          cr.options = c["options"].cast<String>();
        }
        questions.add(cr);
      }
      return questions;
    } else {
      return [];
    }
  }
  Future<bool> submitAnswerscript(AnswerScript answerScript) async {
    print("res");
    var url = basUrl + "/exams/submitanswer";
    var response = await http.post(url, body: {"answerScript": answerScript.toString()});
    var res = jsonDecode(response.body);
    print(response);
    bool success = res['success'];
    return success;
  }
}
