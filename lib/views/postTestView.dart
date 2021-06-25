import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/controllers/topicsViewController.dart';
import 'package:graduation_project/models/user.dart';
import 'package:graduation_project/services/api/api.dart';
import 'package:graduation_project/ui/widgets/failedDialog.dart';
import 'package:graduation_project/ui/widgets/passedDialog.dart';
import 'package:graduation_project/ui/widgets/questionItem.dart';
import 'package:graduation_project/views/topicsView.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';

class PostTestView extends StatelessWidget {
  final postTestID;

  const PostTestView({Key key, this.postTestID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FocusWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: BaseWidget<TopicsViewController>(
            initState: (m) => m.getPostTest(postTestID),
            model: TopicsViewController(
              api: Provider.of<Api>(context),
              auth: Provider.of(context),
            ),
            builder: (context, model, child) {
              return SingleChildScrollView(
                child: model.busy
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ...List.generate(
                            model.postTest.numOfQuestions,
                            (index) => QuestionItem(
                              question: model.postTest.questions[index],
                              onSelect: (answer) =>
                                  model.selectPostTestAnswer(answer, index),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () async {
                              model.calculatePostTestScore();
                              User user = await model.api.endTopicTime(
                                topicID: TopicsViewController
                                    .topics[TopicsViewController.topicIndex].id,
                                conceptID: TopicsViewController.con.id,
                                user: model.auth.user,
                              );
                              model.auth.setUser(user: user);
                              bool passed =
                                  await model.calculatePostTestScore();
                              if (passed) {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: PassedDialog(
                                      buttonText: "Go to topics view",
                                      backButtonText: "materials",
                                      wrongAnswersNums:
                                          model.wrongPostTestAnswers(),
                                      score: model.postTestScore /
                                          model.postTest.numOfQuestions,
                                      proceedOnPressed: () async {
                                        user =
                                            await model.api.completeTopicState(
                                          topicID: TopicsViewController
                                              .topics[TopicsViewController
                                                  .topicIndex]
                                              .id,
                                          conceptID:
                                              TopicsViewController.con.id,
                                          user: model.auth.user,
                                        );
                                        model.auth.setUser(user: user);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => TopicsView(
                                              topicsIDs: TopicsViewController
                                                  .con.topics,
                                              concept: TopicsViewController.con,
                                            ),
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
                                    child: FailedDialog(
                                      buttonText: "Go to topics page",
                                      wrongQuestionsNumbers:
                                          model.wrongPostTestAnswers(),
                                      score: model.preTestScore /
                                          model.preTest.numOfQuestions,
                                      proceedOnPressed: () async {
                                        /* user =
                                            await model.api.completeTopicState(
                                          topicID: TopicsViewController
                                              .topics[TopicsViewController
                                                  .topicIndex]
                                              .id,
                                          conceptID:
                                              TopicsViewController.con.id,
                                          user: model.auth.user,
                                        );
                                        model.auth.setUser(user: user); */
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => TopicsView(
                                              topicsIDs: TopicsViewController
                                                  .con.topics,
                                              concept: TopicsViewController.con,
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
              );
            }),
      ),
    );
  }
}
