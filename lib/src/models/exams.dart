import 'package:onlineexamplatform/src/models/questions.dart';

class Exam {
  String examId, examName, examInstruction, examSubject, examCreator;
  int examTime, examMarks, examDuration;
  bool examAnswerAvailable, examStart;
  List<Question> examQuestions;
  Exam(this.examId, this.examName, this.examInstruction, this.examSubject,
      this.examCreator, this.examTime, this.examMarks);
  void setexamAvailable(bool examAnswerAvailable) {
    this.examAnswerAvailable = examAnswerAvailable;
  }

  void setexamStart(bool examStart) {
    this.examStart = examStart;
  }

  void setexamQuestion(List<Question> examQuestions) {
    this.examQuestions = examQuestions;
  }
}
