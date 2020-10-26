import 'package:onlineexamplatform/src/models/questions.dart';

class AnswerScript {
  String _id, userId, examId;
  int  examMarks;
  List<Question> examScript;
  AnswerScript(this.userId, this.examId);

  void setexamQuestion(List<Question> examQuestions) {
    this.examScript = examScript;
  }
  toJson() {
    return {
      "userId": userId,
      "examId": examId,
      "examScript": examScript,
    };
  }
}
