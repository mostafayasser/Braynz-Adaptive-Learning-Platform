import 'dart:io';

import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation_project/controllers/topicsViewController.dart';
import 'package:graduation_project/services/api/api.dart';
import 'package:graduation_project/ui/widgets/preTestDialog.dart';
import 'package:graduation_project/views/postTestView.dart';
import 'package:graduation_project/views/topicMaterialView.dart';
import 'package:graduation_project/views/topicsView.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoMaterialView extends StatefulWidget {
  final videoData;

  const VideoMaterialView({Key key, this.videoData}) : super(key: key);

  @override
  _VideoMaterialViewState createState() => _VideoMaterialViewState();
}

class _VideoMaterialViewState extends State<VideoMaterialView> {
  double rate = 0;
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayerController.convertUrlToId(widget.videoData.url),
      params: YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    return FocusWidget(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.videoData.name,
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
                builder: (context) => TopicMaterialView(),
              ),
            ),
          ),
          actions: [
            FlatButton(
              color: Colors.transparent,
              child: Text(
                "Next",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    backgroundColor: Colors.transparent,
                    child: StartTestDialog(
                      message: "post test",
                      yesOnPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PostTestView(
                              postTestID: TopicsViewController
                                  .topics[TopicsViewController.topicIndex]
                                  .postTestId,
                            ),
                          ),
                        );
                      },
                      noOnPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TopicsView(
                              concept: TopicsViewController.con,
                              topicsIDs: TopicsViewController.con.topics,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            )
          ],
        ),
        body: BaseWidget<TopicsViewController>(
            model: TopicsViewController(
              api: Provider.of<Api>(context),
              auth: Provider.of(context),
            ),
            builder: (context, model, child) {
              return Column(
                children: [
                  YoutubePlayerIFrame(
                    controller: _controller,
                    aspectRatio: MediaQuery.of(context).size.aspectRatio * 1.3,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemSize: 25,
                        itemBuilder: (context, _) => Icon(
                          Icons.star_rate_rounded,
                          color: Color(0xFFfde129),
                        ),
                        onRatingUpdate: (rating) {
                          rate = rating;
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RaisedButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: Text(
                          "Submit Review",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          print("rate = $rate");
                          model.api.rateMaterial(
                            name: widget.videoData.name,
                            rate: rate,
                            topicID: TopicsViewController
                                .topics[TopicsViewController.topicIndex].id,
                            type: "video",
                          );
                          TopicsViewController
                              .topics[TopicsViewController.topicIndex]
                              .material
                              .videoMaterial
                              .forEach((element) {
                            if (element.name == widget.videoData.name) {
                              if (element.rate != 0 && rate != 0)
                                element.rate = (element.rate + rate) / 2;
                              else if (element.rate == 0)
                                element.rate = element.rate + rate;
                            }
                          });
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Center(
                                    child: Text("Thanks for your rating")),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }
}
