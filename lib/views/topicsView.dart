import 'dart:io';

import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/controllers/topicsViewController.dart';
import 'package:graduation_project/models/concept.dart';
import 'package:graduation_project/models/user.dart';

import 'package:graduation_project/services/api/api.dart';
import 'package:graduation_project/ui/widgets/preTestDialog.dart';
import 'package:graduation_project/views/conceptsView.dart';
import 'package:graduation_project/views/finalTestView.dart';
import 'package:graduation_project/views/preTestView.dart';
import 'package:graduation_project/views/topicMaterialView.dart';
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
          title: Text(
            "Topics View",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color(0xFF3C096C),
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
                      child:
                          Column(crossAxisAlignment: CrossAxisAlignment.center,
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Choose a topic to study",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
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
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: StartTestDialog(
                                        message: "pre test",
                                        yesOnPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => PreTestView(
                                                preTestID: TopicsViewController
                                                    .topics[index].preTestId,
                                              ),
                                            ),
                                          );
                                        },
                                        noOnPressed: () {
                                          Navigator.of(context).pop();
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
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  margin: EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                      color: TopicsViewController.con.id == 1
                                          ? Color(0xFFFFDAB9)
                                          : TopicsViewController.con.id == 2
                                              ? Color(0xFFFBC4AB)
                                              : Color(0xFFF8AD9D),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 3,
                                            offset: Offset(0, 0))
                                      ]),
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                        child: Image.network(
                                          TopicsViewController
                                              .topics[index].imgUrl,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.08,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  child: Text(
                                                    TopicsViewController
                                                        .topics[index].name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                            Icon(
                                              Icons.chevron_right_rounded,
                                              color: Colors.white,
                                              size: 50,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.98,
                              height: MediaQuery.of(context).size.height * 0.1,
                              padding: EdgeInsets.all(10),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Color(0xFF3C096C),
                                child: Text(
                                  "Take final test",
                                  textAlign: TextAlign.center,
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
