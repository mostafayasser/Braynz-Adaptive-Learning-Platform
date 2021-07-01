import 'package:flutter/material.dart';
import 'package:graduation_project/controllers/topicsViewController.dart';
import 'package:graduation_project/views/topicMaterialView.dart';

class FailedFinalTestDialog extends StatelessWidget {
  final buttonText,
      proceedOnPressed,
      wrongQuestionsNumbers,
      score,
      failureMessage,
      reviseTopics;

  const FailedFinalTestDialog({
    Key key,
    this.buttonText,
    this.proceedOnPressed,
    this.wrongQuestionsNumbers,
    this.failureMessage,
    this.score,
    this.reviseTopics,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 3, offset: Offset(0, 0))
          ]),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Unfortunatly you haven't passed the test"),
              SizedBox(
                height: 10,
              ),
              Image.asset(
                "assets/sadIcon.png",
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 10,
              ),
              Text("Your score is ${score * 100}%"),
              SizedBox(
                height: 10,
              ),
              Text("Wrong question(s) numbers are "),
              Wrap(
                children: List.generate(
                  wrongQuestionsNumbers.length,
                  (index) => Text(
                    index != wrongQuestionsNumbers.length - 1
                        ? "${wrongQuestionsNumbers[index].toString()}, "
                        : "${wrongQuestionsNumbers[index].toString()}",
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(failureMessage),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  reviseTopics.length,
                  (index) => Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    margin: EdgeInsets.only(bottom: 10),
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        color: Colors.blue,
                        child: Text(
                          reviseTopics[index],
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          for (int i = 0;
                              i < TopicsViewController.topics.length;
                              i++) {
                            if (TopicsViewController.topics[i].name ==
                                reviseTopics[index]) {
                              TopicsViewController.topicIndex = i;
                              print(TopicsViewController.topics[i].name);
                              print(reviseTopics[index]);
                              print(i);
                              print(TopicsViewController.topicIndex);
                            }
                          }

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TopicMaterialView(),
                            ),
                          );
                        }),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    color: Colors.blue,
                    child: Text(
                      buttonText,
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => proceedOnPressed(),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    color: Colors.blue,
                    child: Text(
                      "Go Back",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
