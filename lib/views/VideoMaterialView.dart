import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation_project/controllers/topicsViewController.dart';
import 'package:graduation_project/services/api/api.dart';
import 'package:graduation_project/views/skipPostTestView.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoMaterialView extends StatefulWidget {
  final videoData, index;

  const VideoMaterialView({Key key, this.videoData, this.index})
      : super(key: key);

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
          actions: [
            FlatButton(
              color: Colors.transparent,
              child: Text(
                "Next",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SkipPostTestView(
                      postTestID: TopicsViewController
                          .topics[TopicsViewController.topicIndex].postTestId,
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
                        allowHalfRating: true,
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
                            index: widget.index,
                            rate: rate,
                            topicID: TopicsViewController
                                .topics[TopicsViewController.topicIndex].id,
                            type: "video",
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
