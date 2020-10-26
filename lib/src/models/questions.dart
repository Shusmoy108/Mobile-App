class Question {
  String _id, questionType, question, answer;
  List<String> options;
  Question(this._id, this.questionType, this.question, this.answer);
  void setOptions(List<String> options) {
    this.options = options;
  }
}
