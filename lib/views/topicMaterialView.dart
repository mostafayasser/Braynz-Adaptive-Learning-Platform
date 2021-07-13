import 'dart:io';

import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
      child: BaseWidget<TopicsViewController>(
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
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFF3C096C),
                centerTitle: true,
                title: Text(
                  TopicsViewController
                      .topics[TopicsViewController.topicIndex].name,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
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
              body: SingleChildScrollView(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choose a material to study",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    model.auth.user.learningStyle.contains("visual")
                        ? visualMaterial(context)
                        : verbalMaterial(context)
                  ],
                ),
              ),
            );
          }),
    );
  }
}

visualMaterial(context) {
  return Column(
    children: <Widget>[
      GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VideoMaterialView(
              videoData: TopicsViewController
                  .topics[TopicsViewController.topicIndex]
                  .material
                  .videoMaterial[0],
            ),
          ),
        ),
        child: MaterialCard(
          image: TopicsViewController.con.id == 1
              ? "assets/intro.jpeg"
              : TopicsViewController.con.id == 2
                  ? "assets/loops.jpeg"
                  : "assets/function.jpeg",
          title: TopicsViewController.topics[TopicsViewController.topicIndex]
              .material.videoMaterial[0].name,
          rating: TopicsViewController.topics[TopicsViewController.topicIndex]
              .material.videoMaterial[0].rate,
          type: "video",
        ),
      ),
      ExpansionTile(
        title: Text("Extra Videos and PDFs Materials"),
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => VideoMaterialView(
                  videoData: TopicsViewController
                      .topics[TopicsViewController.topicIndex]
                      .material
                      .videoMaterial[1],
                ),
              ),
            ),
            child: MaterialCard(
              image: TopicsViewController.con.id == 1
                  ? "assets/intro.jpeg"
                  : TopicsViewController.con.id == 2
                      ? "assets/loops.jpeg"
                      : "assets/function.jpeg",
              title: TopicsViewController
                  .topics[TopicsViewController.topicIndex]
                  .material
                  .videoMaterial[1]
                  .name,
              rating: TopicsViewController
                  .topics[TopicsViewController.topicIndex]
                  .material
                  .videoMaterial[1]
                  .rate,
              type: "video",
            ),
          ),
          ...List.generate(
            TopicsViewController.topics[TopicsViewController.topicIndex]
                .material.pdfMaterial.length,
            (index) => GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PDFMaterialView(
                    pdfData: TopicsViewController
                        .topics[TopicsViewController.topicIndex]
                        .material
                        .pdfMaterial[index],
                  ),
                ),
              ),
              child: MaterialCard(
                image: TopicsViewController.con.id == 1
                    ? "assets/intro.jpeg"
                    : TopicsViewController.con.id == 2
                        ? "assets/loops.jpeg"
                        : "assets/function.jpeg",
                title: TopicsViewController
                    .topics[TopicsViewController.topicIndex]
                    .material
                    .pdfMaterial[index]
                    .name,
                rating: TopicsViewController
                    .topics[TopicsViewController.topicIndex]
                    .material
                    .pdfMaterial[index]
                    .rate,
                type: "pdf",
              ),
            ),
          )
        ],
      ),
    ],
  );
}

verbalMaterial(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PDFMaterialView(
              pdfData: TopicsViewController
                  .topics[TopicsViewController.topicIndex]
                  .material
                  .pdfMaterial[0],
            ),
          ),
        ),
        child: MaterialCard(
          image: TopicsViewController.con.id == 1
              ? "assets/intro.jpeg"
              : TopicsViewController.con.id == 2
                  ? "assets/loops.jpeg"
                  : "assets/function.jpeg",
          title: TopicsViewController.topics[TopicsViewController.topicIndex]
              .material.pdfMaterial[0].name,
          rating: TopicsViewController.topics[TopicsViewController.topicIndex]
              .material.pdfMaterial[0].rate,
          type: "pdf",
        ),
      ),
      ExpansionTile(
        title: Text("Extra Videos and PDFs Materials"),
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PDFMaterialView(
                  pdfData: TopicsViewController
                      .topics[TopicsViewController.topicIndex]
                      .material
                      .pdfMaterial[1],
                ),
              ),
            ),
            child: MaterialCard(
              image: TopicsViewController.con.id == 1
                  ? "assets/intro.jpeg"
                  : TopicsViewController.con.id == 2
                      ? "assets/loops.jpeg"
                      : "assets/function.jpeg",
              title: TopicsViewController
                  .topics[TopicsViewController.topicIndex]
                  .material
                  .pdfMaterial[1]
                  .name,
              rating: TopicsViewController
                  .topics[TopicsViewController.topicIndex]
                  .material
                  .pdfMaterial[1]
                  .rate,
              type: "pdf",
            ),
          ),
          ...List.generate(
            TopicsViewController.topics[TopicsViewController.topicIndex]
                .material.pdfMaterial.length,
            (index) => GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => VideoMaterialView(
                    videoData: TopicsViewController
                        .topics[TopicsViewController.topicIndex]
                        .material
                        .videoMaterial[index],
                  ),
                ),
              ),
              child: MaterialCard(
                image: TopicsViewController.con.id == 1
                    ? "assets/intro.jpeg"
                    : TopicsViewController.con.id == 2
                        ? "assets/loops.jpeg"
                        : "assets/function.jpeg",
                title: TopicsViewController
                    .topics[TopicsViewController.topicIndex]
                    .material
                    .videoMaterial[index]
                    .name,
                rating: TopicsViewController
                    .topics[TopicsViewController.topicIndex]
                    .material
                    .videoMaterial[index]
                    .rate,
                type: "video",
              ),
            ),
          )
        ],
      ),
    ],
  );
}

class MaterialCard extends StatelessWidget {
  final title, image, type, rating;

  const MaterialCard({Key key, this.title, this.image, this.type, this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 3, offset: Offset(0, 0))
          ]),
      alignment: Alignment.center,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
            child: Image.asset(
              image,
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.12,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "type: $type",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 10, color: Colors.grey),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemSize: 15,
                      glowColor: Colors.yellow[700],
                      itemBuilder: (context, _) => Icon(
                        Icons.star_rate_rounded,
                        color: Color(0xFFfde129),
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      rating.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontSize: 10, color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
