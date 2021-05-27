import 'package:base_notifier/base_notifier.dart';
import 'package:graduation_project/models/concept.dart';
import 'package:graduation_project/models/quiz.dart';

import 'package:graduation_project/services/api/http_api.dart';
import 'package:graduation_project/services/auth/authentication_service.dart';

class ConceptsViewController extends BaseNotifier {
  final AuthenticationService auth;
  final HttpApi api;
  ConceptsViewController({NotifierState state, this.api, this.auth})
      : super(state: state);

  List<Concept> concepts;
  Quiz finalTest;
  int finalTestScore = 0;
  List<bool> finalTestAnswers = [];
  static Concept currentConcept;
  getConcepts() async {
    setBusy();
    concepts = await api.getConcepts();
    print(concepts[0].topics);
    setIdle();
  }

  getFinalTest(int testID) async {
    setBusy();
    finalTest = await api.getFinalTest(testID: testID);
    setIdle();
  }

  selectFinalTestAnswer(bool answer, int index) {
    print(index);
    if (finalTestAnswers.isNotEmpty && index <= finalTestAnswers.length - 1)
      finalTestAnswers.removeAt(index);
    finalTestAnswers.insert(index, answer);
    print(finalTestAnswers);
  }

  calculateFinalTestScore() async {
    finalTestScore = 0;
    finalTestAnswers.forEach((element) {
      if (element) finalTestScore++;
    });
    auth.setUser(
      user: await api.setFinalTestScore(
        conceptID: currentConcept.id,
        testScore: finalTestScore,
        user: auth.user,
      ),
    );
    calculateEachTopicScore();
  }

  calculateEachTopicScore() {
    List<Map<String, List<bool>>> topicsList = [];
    List<String> reviseTopics = [];
    for (int i = 0; i < currentConcept.topics.length; i++) {
      List<bool> answers = [];
      String topicName = "";
      for (int j = 0; j < finalTest.numOfQuestions; j++) {
        if (finalTest.questions[j].topicID == currentConcept.topics[i]) {
          answers.add(finalTestAnswers[j]);
          topicName = finalTest.questions[j].topicName;
        }
      }

      topicsList.add({topicName: answers});
    }
    topicsList.forEach((element) {
      int score = 0;
      element.values.forEach((value) {
        value.forEach((v) {
          if (!v) score++;
        });
      });
      if (score >= 2) reviseTopics.add(element.keys.first);
    });
    if (reviseTopics.isNotEmpty) {
      print("You need to revise the following topics: ");
      reviseTopics.forEach((element) {
        print(element);
      });
    }
  }
}
