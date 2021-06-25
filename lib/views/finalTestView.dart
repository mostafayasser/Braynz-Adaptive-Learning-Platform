import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/controllers/conceptsViewController.dart';
import 'package:graduation_project/services/api/api.dart';
import 'package:graduation_project/ui/widgets/failedFinalTestDialog.dart';
import 'package:graduation_project/ui/widgets/passedDialog.dart';
import 'package:graduation_project/ui/widgets/questionItem.dart';
import 'package:graduation_project/views/conceptsView.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';

class FinalTestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FocusWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: BaseWidget<ConceptsViewController>(
            initState: (m) => m.getTest(
                  ConceptsViewController.currentConcept.finalTestID,
                  "final",
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
                                    onPressed: () async {
                                      bool passed = await model
                                          .calculateTestScore("final");
                                      List<String> reviseTopics =
                                          model.calculateEachTopicScore();
                                      if (passed) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                            backgroundColor: Colors.transparent,
                                            child: PassedDialog(
                                              buttonText: "Proceed to concepts",
                                              backButtonText: "topics view",
                                              wrongAnswersNums:
                                                  model.wrongTestAnswers(),
                                              score: model.testScore /
                                                  model.test.numOfQuestions,
                                              proceedOnPressed: () {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ConceptsView(),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                            backgroundColor: Colors.transparent,
                                            child: FailedFinalTestDialog(
                                              buttonText: "Proceed to concepts",
                                              wrongQuestionsNumbers:
                                                  model.wrongTestAnswers(),
                                              failureMessage:
                                                  "You need to revise following topic(s)",
                                              score: model.testScore /
                                                  model.test.numOfQuestions,
                                              reviseTopics: reviseTopics,
                                              proceedOnPressed: () {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ConceptsView(),
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
