import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/controllers/conceptsViewController.dart';
import 'package:graduation_project/services/api/api.dart';
import 'package:graduation_project/ui/widgets/questionItem.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';

class FinalTestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FocusWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: BaseWidget<ConceptsViewController>(
            initState: (m) => m.getFinalTest(
                ConceptsViewController.currentConcept.finalTestID),
            model: ConceptsViewController(
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
                            model.finalTest.numOfQuestions,
                            (index) => QuestionItem(
                              question: model.finalTest.questions[index],
                              onSelect: (answer) =>
                                  model.selectFinalTestAnswer(answer, index),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              model.calculateFinalTestScore();
                              /* Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => ConceptsView(),
                                ),
                              ); */
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
