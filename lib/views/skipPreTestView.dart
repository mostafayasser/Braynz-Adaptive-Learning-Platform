import 'package:flutter/material.dart';
import 'package:graduation_project/views/preTestView.dart';
import 'package:graduation_project/views/topicMaterialView.dart';

class SkipPreTestView extends StatelessWidget {
  final preTestID;

  const SkipPreTestView({Key key, this.preTestID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Would you like to take a pre test?"),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PreTestView(
                    preTestID: preTestID,
                  ),
                ));
              },
              child: Text("Start Pre test"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TopicMaterialView(),
                  ),
                );
              },
              child: Text("Proceed to material"),
            ),
          ],
        ),
      ),
    );
  }
}
