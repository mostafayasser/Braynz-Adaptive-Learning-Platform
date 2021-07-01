import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/controllers/conceptsViewController.dart';
import 'package:graduation_project/services/api/api.dart';
import 'package:graduation_project/ui/widgets/failedFinalTestDialog.dart';
import 'package:graduation_project/ui/widgets/passedDialog.dart';
import 'package:graduation_project/ui/widgets/questionItem.dart';
import 'package:graduation_project/views/topicsView.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';

class ConceptPreTestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FocusWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: BaseWidget<ConceptsViewController>(
            initState: (m) => m.getTest(
                  ConceptsViewController.currentConcept.preTestID,
                  "pre",
                ),
            model: ConceptsViewController(
              api: Provider.of<Api>(context),
              auth: Provider.of(context),
            ),
            builder: (context, model, child) {
              return Center(
                child: SingleChildScrollView(
                  child: model.busy
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ...List.generate(
                              model.test.numOfQuestions,
                              (index) => QuestionItem(
                                question: model.test.questions[index],
                                onSelect: (answer) =>
                                    model.selectTestAnswer(answer, index),
                              ),
                            ),
                            model.busy
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : RaisedButton(
                                    onPressed: model.testAnswers.isEmpty
                                        ? () {
                                            print("in");
                                          }
                                        : () async {
                                            bool passed = await model
                                                .calculateTestScore("pre");
                                            List<String> reviseTopics =
                                                model.calculateEachTopicScore();
                                            if (passed) {
                                              model.changeTopicsStateToComplete(
                                                topics: ConceptsViewController
                                                    .currentConcept.topics,
                                                state: "passed",
                                              );
                                              showDialog(
                                                context: context,
                                                builder: (context) => Dialog(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: PassedDialog(
                                                    buttonText:
                                                        "Proceed to topics",
                                                    backButtonText:
                                                        "concepts view",
                                                    wrongAnswersNums: model
                                                        .wrongTestAnswers(),
                                                    score: double.parse(((model
                                                                    .testScore /
                                                                model.test
                                                                    .numOfQuestions) *
                                                            100)
                                                        .toStringAsFixed(1)),
                                                    proceedOnPressed: () {
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              TopicsView(
                                                            concept:
                                                                ConceptsViewController
                                                                    .currentConcept,
                                                            topicsIDs:
                                                                ConceptsViewController
                                                                    .currentConcept
                                                                    .topics,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            } else {
                                              model.changeTopicsStateToComplete(
                                                topics: reviseTopics,
                                                state: "failed",
                                              );
                                              showDialog(
                                                context: context,
                                                builder: (context) => Dialog(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: FailedFinalTestDialog(
                                                    buttonText:
                                                        "Proceed to topics",
                                                    wrongQuestionsNumbers: model
                                                        .wrongTestAnswers(),
                                                    failureMessage:
                                                        "You need to study following topic(s)",
                                                    score: double.parse(((model
                                                                .testScore /
                                                            model.test
                                                                .numOfQuestions))
                                                        .toStringAsFixed(1)),
                                                    reviseTopics: reviseTopics,
                                                    proceedOnPressed: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              TopicsView(
                                                            concept:
                                                                ConceptsViewController
                                                                    .currentConcept,
                                                            topicsIDs:
                                                                ConceptsViewController
                                                                    .currentConcept
                                                                    .topics,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                    child: Text("Submit"),
                                  )
                          ],
                        ),
                ),
              );
            }),
      ),
    );
  }
}
