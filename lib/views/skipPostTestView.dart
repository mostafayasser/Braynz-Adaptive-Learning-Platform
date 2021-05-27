import 'package:flutter/material.dart';
import 'package:graduation_project/controllers/topicsViewController.dart';
import 'package:graduation_project/views/postTestView.dart';
import 'package:graduation_project/views/topicsView.dart';

class SkipPostTestView extends StatelessWidget {
  final postTestID;

  const SkipPostTestView({Key key, this.postTestID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
              onPressed: () {
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
  }
}
