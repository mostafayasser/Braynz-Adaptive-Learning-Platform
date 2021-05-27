class Question {
  int topicID;
  String question;
  int answer;
  List<String> answers;
  Question({this.topicID, this.question, this.answer, this.answers});
  factory Question.fromJson(Map<String, dynamic> json) => Question(
      topicID: json["topicID"],
      answer: json["answer"],
      question: json["question"],
      answers: List<String>.from(json["answers"].map((x) => x.toString())));
}
