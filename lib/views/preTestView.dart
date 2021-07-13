import 'dart:io';

import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/controllers/topicsViewController.dart';
import 'package:graduation_project/models/user.dart';
import 'package:graduation_project/services/api/api.dart';
import 'package:graduation_project/ui/widgets/failedDialog.dart';
import 'package:graduation_project/ui/widgets/passedDialog.dart';
import 'package:graduation_project/ui/widgets/questionItem.dart';
import 'package:graduation_project/views/topicMaterialView.dart';
import 'package:graduation_project/views/topicsView.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';

class PreTestView extends StatelessWidget {
  final preTestID;

  const PreTestView({Key key, this.preTestID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FocusWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Pre Test",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Platform.isIOS
                ? Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => TopicsView(
                  topicsIDs: TopicsViewController.ids,
                  concept: TopicsViewController.con,
                ),
              ),
            ),
          ),
        ),
        body: BaseWidget<TopicsViewController>(
            initState: (m) => m.getPreTest(preTestID),
            model: TopicsViewController(
              api: Provider.of<Api>(context),
              auth: Provider.of(context),
            ),
            builder: (context, model, child) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(15),
                child: model.busy
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Please note that you have to answer all question and answer them in order",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ...List.generate(
                            model.preTest.numOfQuestions,
                            (index) => QuestionItem(
                              question: model.preTest.questions[index],
                              onSelect: (answer) =>
                                  model.selectPreTestAnswer(answer, index),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: RaisedButton(
                              onPressed: () async {
                                bool passed =
                                    await model.calculatePreTestScore();
                                List<int> numbers = model.wrongPreTestAnswers();
                                if (passed) {
                                  User user =
                                      await model.api.completeTopicState(
                                    topicID: TopicsViewController
                                        .topics[TopicsViewController.topicIndex]
                                        .id,
                                    conceptID: TopicsViewController.con.id,
                                    user: model.auth.user,
                                  );
                                  model.auth.setUser(user: user);
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: PassedDialog(
                                          buttonText: "Proceed to material",
                                          backButtonText: "topics view",
                                          wrongAnswersNums: numbers,
                                          score: double.parse(
                                              ((model.preTestScore /
                                                          model.preTest
                                                              .numOfQuestions) *
                                                      100)
                                                  .toStringAsFixed(1)),
                                          proceedOnPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TopicMaterialView(),
                                              ),
                                            );
                                          },
                                          backOnPressed: () {
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TopicsView(
                                                  concept:
                                                      TopicsViewController.con,
                                                  topicsIDs:
                                                      TopicsViewController
                                                          .con.topics,
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: FailedDialog(
                                        buttonText: "Proceed to material",
                                        wrongQuestionsNumbers: numbers,
                                        score: double.parse(
                                            ((model.preTestScore /
                                                        model.preTest
                                                            .numOfQuestions) *
                                                    100)
                                                .toStringAsFixed(1)),
                                        proceedOnPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TopicMaterialView(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                }
                                /* Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => TopicMaterialView(),
                                  ),
                                ); */
                              },
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
              );
            }),
      ),
    );
  }
}
