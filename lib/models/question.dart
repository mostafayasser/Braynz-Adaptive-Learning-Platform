class Question {
  int topicID;
  String question, topicName, hint;
  int answer;
  List<String> answers;

  Question(
      {this.topicID,
      this.question,
      this.answer,
      this.answers,
      this.topicName,
      this.hint});
  factory Question.fromJson(Map<String, dynamic> json) => Question(
      topicID: json["topicID"],
      answer: json["answer"],
      question: json["question"],
      topicName: json["topicName"],
      hint: json["hint"],
      answers: List<String>.from(json["answers"].map((x) => x.toString())));
}
