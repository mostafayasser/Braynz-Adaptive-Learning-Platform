import 'package:flutter/material.dart';
import 'package:graduation_project/ui/widgets/failedDialog.dart';

class FirebaseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FlatButton(
            onPressed: () {
              List<int> numbers = [1, 2, 3];
              showDialog(
                useSafeArea: false,
                context: context,
                builder: (context) => Dialog(
                  backgroundColor: Colors.transparent,
                  child: FailedDialog(
                    buttonText: "Proceed to material",
                    wrongQuestionsNumbers: numbers,
                    proceedOnPressed: () {
                      print("object");
                    },
                  ),
                ),
              );
              /* final FirebaseFirestore store = FirebaseFirestore.instance;
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
              }); */
            },
            child: Text("submit")),
      ),
    );
  }
}
