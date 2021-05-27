import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation_project/controllers/topicsViewController.dart';
import 'package:graduation_project/services/api/api.dart';
import 'package:graduation_project/views/skipPostTestView.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';

class PDFMaterialView extends StatefulWidget {
  final pdfData, index;

  const PDFMaterialView({Key key, this.pdfData, this.index}) : super(key: key);

  @override
  _PDFMaterialViewState createState() => _PDFMaterialViewState();
}

class _PDFMaterialViewState extends State<PDFMaterialView> {
  double rate = 0;

  @override
  Widget build(BuildContext context) {
    return FocusWidget(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.pdfData.name,
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
            initState: (m) => m.loadPdfFile(widget.pdfData.url),
            model: TopicsViewController(
              api: Provider.of<Api>(context),
              auth: Provider.of(context),
            ),
            builder: (context, model, child) {
              return model.busy
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * .8,
                            child: PDFViewer(document: model.pdf)),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RatingBar.builder(
                              initialRating: 5,
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
                                      .topics[TopicsViewController.topicIndex]
                                      .id,
                                  type: "pdf",
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
