import 'dart:io';

import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/controllers/topicsViewController.dart';
import 'package:graduation_project/services/api/api.dart';
import 'package:graduation_project/views/VideoMaterialView.dart';
import 'package:graduation_project/views/pdfMaterialView.dart';
import 'package:graduation_project/views/topicsView.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';

class TopicMaterialView extends StatelessWidget {
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
                      builder: (context) => TopicsView(),
                    ),
                  )),
        ),
        body: BaseWidget<TopicsViewController>(
            initState: (m) => m.api.increaseTimesOfStudy(
                topicID: TopicsViewController
                    .topics[TopicsViewController.topicIndex].id,
                conceptID: TopicsViewController.con.id,
                user: m.auth.user),
            model: TopicsViewController(
              api: Provider.of<Api>(context),
              auth: Provider.of(context),
            ),
            builder: (context, model, child) {
              return Center(
                child: SingleChildScrollView(
                  child: model.auth.user.learningStyle.contains("visual")
                      ? visualMaterial(context)
                      : verbalMaterial(context),
                ),
              );
            }),
      ),
    );
  }
}

visualMaterial(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      ...List.generate(
        TopicsViewController.topics[TopicsViewController.topicIndex].material
            .videoMaterial.length,
        (index) => GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => VideoMaterialView(
                videoData: TopicsViewController
                    .topics[TopicsViewController.topicIndex]
                    .material
                    .videoMaterial[index],
                index: index,
              ),
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * .5,
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                      offset: Offset(0, 0))
                ]),
            child: Column(
              children: [
                Text(TopicsViewController
                    .topics[TopicsViewController.topicIndex]
                    .material
                    .videoMaterial[index]
                    .name),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star_rate_rounded,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(TopicsViewController
                        .topics[TopicsViewController.topicIndex]
                        .material
                        .videoMaterial[index]
                        .rate
                        .toString()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      ...List.generate(
        TopicsViewController.topics[TopicsViewController.topicIndex].material
            .pdfMaterial.length,
        (index) => GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PDFMaterialView(
                pdfData: TopicsViewController
                    .topics[TopicsViewController.topicIndex]
                    .material
                    .pdfMaterial[index],
                index: index,
              ),
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * .5,
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                      offset: Offset(0, 0))
                ]),
            child: Column(
              children: [
                Text(TopicsViewController
                    .topics[TopicsViewController.topicIndex]
                    .material
                    .pdfMaterial[index]
                    .name),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star_rate_rounded,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(TopicsViewController
                        .topics[TopicsViewController.topicIndex]
                        .material
                        .pdfMaterial[index]
                        .rate
                        .toString()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

verbalMaterial(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      ...List.generate(
        TopicsViewController.topics[TopicsViewController.topicIndex].material
            .pdfMaterial.length,
        (index) => GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PDFMaterialView(
                pdfData: TopicsViewController
                    .topics[TopicsViewController.topicIndex]
                    .material
                    .pdfMaterial[index],
                index: index,
              ),
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * .5,
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                      offset: Offset(0, 0))
                ]),
            child: Column(
              children: [
                Text(TopicsViewController
                    .topics[TopicsViewController.topicIndex]
                    .material
                    .pdfMaterial[index]
                    .name),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star_rate_rounded,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(TopicsViewController
                        .topics[TopicsViewController.topicIndex]
                        .material
                        .pdfMaterial[index]
                        .rate
                        .toString()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      ...List.generate(
        TopicsViewController.topics[TopicsViewController.topicIndex].material
            .videoMaterial.length,
        (index) => GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => VideoMaterialView(
                videoData: TopicsViewController
                    .topics[TopicsViewController.topicIndex]
                    .material
                    .videoMaterial[index],
                index: index,
              ),
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * .5,
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                      offset: Offset(0, 0))
                ]),
            child: Column(
              children: [
                Text(TopicsViewController
                    .topics[TopicsViewController.topicIndex]
                    .material
                    .videoMaterial[index]
                    .name),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star_rate_rounded,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(TopicsViewController
                        .topics[TopicsViewController.topicIndex]
                        .material
                        .videoMaterial[index]
                        .rate
                        .toString()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
