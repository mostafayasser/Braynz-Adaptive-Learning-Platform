import 'dart:io';

import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/controllers/topicsViewController.dart';
import 'package:graduation_project/models/concept.dart';
import 'package:graduation_project/models/user.dart';

import 'package:graduation_project/services/api/api.dart';
import 'package:graduation_project/views/conceptsView.dart';
import 'package:graduation_project/views/finalTestView.dart';
import 'package:graduation_project/views/skipPreTestView.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';

class TopicsView extends StatelessWidget {
  final List<dynamic> topicsIDs;
  final Concept concept;

  const TopicsView({Key key, this.topicsIDs, this.concept}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FocusWidget(
      child: Scaffold(
        appBar: AppBar(
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
                      builder: (context) => ConceptsView(),
                    ),
                  )),
        ),
        body: BaseWidget<TopicsViewController>(
            initState: (m) => m.getTopics(
                  topicIDs: topicsIDs,
                  conc: concept,
                ),
            model: TopicsViewController(
              api: Provider.of<Api>(context),
              auth: Provider.of(context),
            ),
            builder: (context, model, child) {
              return model.busy
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(
                              TopicsViewController.topics.length,
                              (index) => GestureDetector(
                                onTap: () async {
                                  TopicsViewController.topicIndex = index;
                                  if (concept != null) {
                                    TopicsViewController.con = concept;
                                    User user = await model.api.addTopic(
                                        conceptID: concept.id,
                                        topicID: TopicsViewController
                                            .topics[index].id,
                                        user: model.auth.user);
                                    model.auth.setUser(user: user);
                                  }
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SkipPreTestView(
                                      preTestID: TopicsViewController
                                          .topics[index].preTestId,
                                    ),
                                  ));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(20),
                                  width: MediaQuery.of(context).size.width * .4,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 3,
                                            offset: Offset(0, 0))
                                      ]),
                                  child: Text(
                                    TopicsViewController.topics[index].name,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              color: Colors.blue,
                              child: Text(
                                "Take final test",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => FinalTestView(),
                                ),
                              ),
                            ),
                          ]),
                    );
            }),
      ),
    );
  }
}
