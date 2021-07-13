import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:base_notifier/base_notifier.dart';
import 'package:graduation_project/models/concept.dart';
import 'package:graduation_project/models/quiz.dart';
import 'package:graduation_project/models/topic.dart';

import 'package:graduation_project/services/api/http_api.dart';
import 'package:graduation_project/services/auth/authentication_service.dart';

class TopicsViewController extends BaseNotifier {
  final AuthenticationService auth;
  final HttpApi api;
  TopicsViewController({NotifierState state, this.api, this.auth})
      : super(state: state);

  static List<Topic> topics = [];
  static Map<int, String> statuses = {};
  Quiz preTest, postTest;
  static int topicIndex = 0;
  static Concept con;
  int preTestScore = 0, postTestScore = 0;
  List<bool> preTestAnswers = [], postTestAnswers = [];
  PDFDocument pdf;
  static List<dynamic> ids = [];

  getTopics({List<dynamic> topicIDs, Concept conc}) async {
    setBusy();
    con = conc;
    ids = topicIDs;
    topics = await api.getTopics(topicsIDs: ids);
    var concept = auth.user.concepts.where((element) => element.id == con.id);

    for (int i = 0; i < concept.first.topics.length; i++) {
      statuses[concept.first.topics[i].id] = concept.first.topics[i].state;
    }
    print(statuses);
    setIdle();
  }

  getPreTest(int testID) async {
    setBusy();
    preTest = await api.getPreTest(testID: testID);
    print(preTest.questions.length);
    setIdle();
  }

  getPostTest(int testID) async {
    setBusy();
    postTest = await api.getPostTest(testID: testID);
    print(postTest.questions.length);
    setIdle();
  }

  selectPreTestAnswer(bool answer, int index) {
    print(index);
    if (preTestAnswers.isNotEmpty && index <= preTestAnswers.length - 1)
      preTestAnswers.removeAt(index);
    preTestAnswers.insert(index, answer);
    print(preTestAnswers);
  }

  selectPostTestAnswer(bool answer, int index) {
    print(index);
    if (postTestAnswers.isNotEmpty && index <= postTestAnswers.length - 1)
      postTestAnswers.removeAt(index);
    postTestAnswers.insert(index, answer);
    print(postTestAnswers);
  }

  Future<bool> calculatePreTestScore() async {
    preTestScore = 0;
    preTestAnswers.forEach((element) {
      if (element) preTestScore++;
    });
    auth.setUser(
      user: await api.setPreTestScore(
        topicID: topics[topicIndex].id,
        testScore: double.parse(
            ((preTestScore / preTest.numOfQuestions) * 100).toStringAsFixed(1)),
        conceptID: con.id,
        user: auth.user,
      ),
    );
    if (preTestScore >= (preTest.numOfQuestions * .6)) return true;
    return false;
  }

  Future<bool> calculatePostTestScore() async {
    postTestScore = 0;
    postTestAnswers.forEach((element) {
      if (element) postTestScore++;
    });
    auth.setUser(
      user: await api.setPostTestScore(
        topicID: topics[topicIndex].id,
        testScore: double.parse(
            ((postTestScore / postTest.numOfQuestions) * 100)
                .toStringAsFixed(1)),
        conceptID: con.id,
        user: auth.user,
      ),
    );
    if (postTestScore >= (postTest.numOfQuestions * .6)) return true;
    return false;
  }

  List<int> wrongPreTestAnswers() {
    List<int> numbers = [];
    for (int i = 0; i < preTest.numOfQuestions; i++) {
      if (!preTestAnswers[i]) numbers.add(i + 1);
    }
    return numbers;
  }

  List<int> wrongPostTestAnswers() {
    List<int> numbers = [];
    for (int i = 0; i < postTest.numOfQuestions; i++) {
      if (!postTestAnswers[i]) numbers.add(i + 1);
    }
    return numbers;
  }

  loadPdfFile(String url) async {
    setBusy();
    pdf = await PDFDocument.fromURL(url);

    setIdle();
  }
}
