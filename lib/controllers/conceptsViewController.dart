import 'package:base_notifier/base_notifier.dart';
import 'package:graduation_project/controllers/topicsViewController.dart';
import 'package:graduation_project/models/concept.dart';
import 'package:graduation_project/models/dashboard.dart';
import 'package:graduation_project/models/quiz.dart';
import 'package:graduation_project/models/user.dart';

import 'package:graduation_project/services/api/http_api.dart';
import 'package:graduation_project/services/auth/authentication_service.dart';

class ConceptsViewController extends BaseNotifier {
  final AuthenticationService auth;
  final HttpApi api;
  ConceptsViewController({NotifierState state, this.api, this.auth})
      : super(state: state);

  List<Concept> concepts;
  Quiz test;
  int testScore = 0;
  List<bool> testAnswers = [];
  static Concept currentConcept;
  Dashboard dashboard;

  getConcepts() async {
    setBusy();
    concepts = await api.getConcepts();
    setIdle();
  }

  getDashboard() async {
    setBusy();
    dashboard = await api.getUserDashboard(auth.user);
    setIdle();
  }

  getTest(int testID, String type) async {
    setBusy();
    if (type == "final")
      test = await api.getFinalTest(testID: testID);
    else
      test = await api.getConceptPreTest(testID: testID);
    setIdle();
  }

  selectTestAnswer(bool answer, int index) {
    print(index);
    if (testAnswers.isNotEmpty && index <= testAnswers.length - 1)
      testAnswers.removeAt(index);
    testAnswers.insert(index, answer);
    setState();
    print(testAnswers);
  }

  Future<bool> calculateTestScore(String type) async {
    setBusy();
    testScore = 0;
    testAnswers.forEach((element) {
      if (element) testScore++;
    });
    if (type == "final") {
      auth.setUser(
        user: await api.setFinalTestScore(
          conceptID: currentConcept.id,
          testScore: double.parse(
              ((testScore / test.numOfQuestions) * 100).toStringAsFixed(1)),
          user: auth.user,
        ),
      );
    } else {
      auth.setUser(
        user: await api.setConceptPreTestScore(
          conceptID: currentConcept.id,
          testScore: double.parse(
              ((testScore / test.numOfQuestions) * 100).toStringAsFixed(1)),
          user: auth.user,
        ),
      );
    }
    setIdle();
    List<String> topics = calculateEachTopicScore();
    if ((testScore >= (test.numOfQuestions * .75)) && topics.isEmpty)
      return true;
    return false;
  }

  changeTopicsStateToComplete({List<dynamic> topics, String state}) async {
    setBusy();
    User user;
    if (state == "passed") {
      for (int i = 0; i < topics.length; i++) {
        user = await api.completeTopicState(
          topicID: topics[i],
          conceptID: currentConcept.id,
          user: auth.user,
          add: true,
        );
      }
    } else {
      List<int> ids = [];
      var topicsList = await api.getTopics(topicsIDs: currentConcept.topics);
      TopicsViewController.con = currentConcept;
      TopicsViewController.topics = topicsList;
      TopicsViewController.ids = currentConcept.topics;
      for (int i = 0; i < topicsList.length; i++) {
        print(topics.contains(topicsList[i].name));
        if (!topics.contains(topicsList[i].name)) {
          ids.add(topicsList[i].id);
        }
      }
      if (ids.isNotEmpty) {
        for (int i = 0; i < ids.length; i++) {
          user = await api.completeTopicState(
            topicID: ids[i],
            conceptID: currentConcept.id,
            user: auth.user,
          );
        }
      }
    }
    if (user != null) auth.setUser(user: user);

    setIdle();
  }

  completeConcept() async {
    setBusy();
    User user;
    user = await api.changeConceptStatusToCompleted(
        conceptID: currentConcept.id, user: auth.user);
    if (user != null) auth.setUser(user: user);

    setIdle();
  }

  List<int> wrongTestAnswers() {
    List<int> numbers = [];
    for (int i = 0; i < test.numOfQuestions; i++) {
      if (!testAnswers[i]) numbers.add(i + 1);
    }
    return numbers;
  }

  List<String> calculateEachTopicScore() {
    List<Map<String, List<bool>>> topicsList = [];
    List<String> topics = [];
    for (int i = 0; i < currentConcept.topics.length; i++) {
      List<bool> answers = [];
      String topicName = "";
      for (int j = 0; j < test.numOfQuestions; j++) {
        if (test.questions[j].topicID == currentConcept.topics[i]) {
          answers.add(testAnswers[j]);
          topicName = test.questions[j].topicName;
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
      if (score >= 2) topics.add(element.keys.first);
    });
    if (topics.isNotEmpty) {
      topics.forEach((element) {
        print(element);
      });
    }
    return topics;
  }
}
