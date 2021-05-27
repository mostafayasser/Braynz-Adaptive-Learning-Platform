import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/controllers/topicsViewController.dart';
import 'package:graduation_project/services/api/api.dart';
import 'package:graduation_project/ui/widgets/questionItem.dart';
import 'package:graduation_project/views/topicMaterialView.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';

class PreTestView extends StatelessWidget {
  final preTestID;

  const PreTestView({Key key, this.preTestID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FocusWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: BaseWidget<TopicsViewController>(
            initState: (m) => m.getPreTest(preTestID),
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
                            model.preTest.numOfQuestions,
                            (index) => QuestionItem(
                              question: model.preTest.questions[index],
                              onSelect: (answer) =>
                                  model.selectPreTestAnswer(answer, index),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              model.calculatePreTestScore();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => TopicMaterialView(),
                                ),
                              );
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
