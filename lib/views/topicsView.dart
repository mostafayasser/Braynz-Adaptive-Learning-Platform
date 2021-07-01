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
    print(topicsIDs);
    return FocusWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Topics View",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                                        conceptID: TopicsViewController.con.id,
                                        topicID: TopicsViewController
                                            .topics[index].id,
                                        user: model.auth.user);
                                    model.auth.setUser(user: user);
                                  }
                                  User user = await model.api.startTopicTime(
                                    topicID:
                                        TopicsViewController.topics[index].id,
                                    conceptID: TopicsViewController.con.id,
                                    user: model.auth.user,
                                  );
                                  model.auth.setUser(user: user);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SkipPreTestView(
                                      preTestID: TopicsViewController
                                          .topics[index].preTestId,
                                    ),
                                  ));
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height:
                                      MediaQuery.of(context).size.height * 0.13,
                                  margin: EdgeInsets.only(bottom: 10),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: AssetImage(index == 0
                                              ? "assets/Joomla.jpg"
                                              : "assets/Forest.jpg"),
                                          fit: BoxFit.cover),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 3,
                                            offset: Offset(0, 0))
                                      ]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        TopicsViewController.topics[index].name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      /* Text(
                                        TopicsViewController
                                            .topics[index].status,
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ), */
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                color: Colors.blue,
                                child: Text(
                                  "Take final test",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => FinalTestView(),
                                  ),
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
