import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FlatButton(
            onPressed: () {
              final FirebaseFirestore store = FirebaseFirestore.instance;
              store
                  .collection("tests")
                  .doc("2")
                  .collection("question8")
                  .doc("8")
                  .set({
                "answer": 1,
                "answers": [
                  "answer1",
                  "answer2",
                  "answer3",
                  "answer4",
                ],
                "question": "question",
                "topicName": "while loops",
                "topicID": 2
              });
            },
            child: Text("submit")),
      ),
    );
  }
}
