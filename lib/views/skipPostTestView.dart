import 'package:flutter/material.dart';
import 'package:graduation_project/controllers/topicsViewController.dart';
import 'package:graduation_project/models/user.dart';
import 'package:graduation_project/views/postTestView.dart';
import 'package:graduation_project/views/topicsView.dart';

import 'package:base_notifier/base_notifier.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/services/api/api.dart';
import 'package:ui_utils/ui_utils.dart';

class SkipPostTestView extends StatelessWidget {
  final postTestID;

  const SkipPostTestView({Key key, this.postTestID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FocusWidget(
      child: BaseWidget<TopicsViewController>(
          model: TopicsViewController(
            api: Provider.of<Api>(context),
            auth: Provider.of(context),
          ),
          builder: (context, model, child) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Would you like to take a post test?"),
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PostTestView(
                              postTestID: postTestID,
                            ),
                          ),
                        );
                      },
                      child: Text("Start Post test"),
                    ),
                    RaisedButton(
                      onPressed: () async {
                        User user = await model.api.endTopicTime(
                          topicID: TopicsViewController
                              .topics[TopicsViewController.topicIndex].id,
                          user: model.auth.user,
                        );

                        model.auth.setUser(user: user);
                        user = await model.api.completeTopicState(
                          topicID: TopicsViewController
                              .topics[TopicsViewController.topicIndex].id,
                          user: model.auth.user,
                        );
                        model.auth.setUser(user: user);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TopicsView(
                              topicsIDs: TopicsViewController.con.topics,
                              concept: TopicsViewController.con,
                            ),
                          ),
                        );
                      },
                      child: Text("Proceed to topics page"),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
