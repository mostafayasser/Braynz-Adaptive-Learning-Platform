import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/controllers/learningStyleTestViewController.dart';
import 'package:graduation_project/services/api/api.dart';
import 'package:graduation_project/views/conceptsView.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';

class LearningStyleTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(DateTime.now().toString());
    return FocusWidget(
      child: Scaffold(
        body: BaseWidget<LearningStyleTestViewController>(
            model: LearningStyleTestViewController(
              auth: Provider.of(context),
              api: Provider.of<Api>(context),
            ),
            builder: (context, model, child) {
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    "Learning Style Quiz",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                body: SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Item(
                        quiestion: "1. I understand something better after I",
                        answers: ["try it out.", "think it through."],
                        onSelect: model.selectActRef,
                      ),
                      Item(
                        quiestion:
                            "2. When I think about what I did yesterday, I am most likely to get",
                        answers: ["a picture", "words"],
                        onSelect: model.selectVisVer,
                      ),
                      Item(
                        quiestion:
                            "3. When I am learning something new, it helps me to",
                        answers: ["talk about it.", "think about it."],
                        onSelect: model.selectActRef,
                      ),
                      Item(
                        quiestion: "4. I prefer to get new information in",
                        answers: [
                          "pictures, diagrams, graphs, or maps.",
                          "written directions or verbal information."
                        ],
                        onSelect: model.selectVisVer,
                      ),
                      Item(
                        quiestion:
                            "5. In a study group working on difficult material, I am more likely to",
                        answers: [
                          "jump in and contribute ideas.",
                          "sit back and listen."
                        ],
                        onSelect: model.selectActRef,
                      ),
                      Item(
                        quiestion:
                            "6. In a book with lots of pictures and charts, I am likely to",
                        answers: [
                          "look over the pictures and charts carefully.",
                          "focus on the written text."
                        ],
                        onSelect: model.selectVisVer,
                      ),
                      Item(
                        quiestion: "7. In classes I have taken",
                        answers: [
                          "I have usually gotten to know many of the students.",
                          "I have rarely gotten to know many of the students."
                        ],
                        onSelect: model.selectActRef,
                      ),
                      Item(
                        quiestion: "8. I like teachers",
                        answers: [
                          "who put a lot of diagrams on the board.",
                          "who spend a lot of time explaining."
                        ],
                        onSelect: model.selectVisVer,
                      ),
                      Item(
                        quiestion:
                            "9. When I start a homework problem, I am more likely to",
                        answers: [
                          "start working on the solution immediately.",
                          "try to fully understand the problem first."
                        ],
                        onSelect: model.selectActRef,
                      ),
                      Item(
                        quiestion: "10. I remember best",
                        answers: ["what I see.", "what I hear."],
                        onSelect: model.selectVisVer,
                      ),
                      Item(
                        quiestion: "11. I prefer to study",
                        answers: ["in a study group.", "alone."],
                        onSelect: model.selectActRef,
                      ),
                      Item(
                        quiestion:
                            "12. When I get directions to a new place, I prefer",
                        answers: ["a map.", "written directions."],
                        onSelect: model.selectVisVer,
                      ),
                      Item(
                        quiestion: "13. I would rather first",
                        answers: [
                          "try things out.",
                          "think about how I'm going to do it."
                        ],
                        onSelect: model.selectActRef,
                      ),
                      Item(
                        quiestion:
                            "14. When I see a diagram or sketch in class, I am most likely to remember",
                        answers: [
                          "the picture.",
                          "what the instructor said about it."
                        ],
                        onSelect: model.selectVisVer,
                      ),
                      Item(
                        quiestion: "15. I more easily remember",
                        answers: [
                          "something I have done.",
                          "something I have thought a lot about."
                        ],
                        onSelect: model.selectActRef,
                      ),
                      Item(
                        quiestion:
                            "16. When someone is showing me data, I prefer",
                        answers: [
                          "charts or graphs.",
                          "text summarizing the results."
                        ],
                        onSelect: model.selectVisVer,
                      ),
                      Item(
                        quiestion:
                            "17. When I have to work on a group project, I first want to",
                        answers: [
                          "have \"group brainstorming\" where everyone contributes ideas.",
                          "brainstorm individually and then come together as a group to compare ideas."
                        ],
                        onSelect: model.selectActRef,
                      ),
                      Item(
                        quiestion:
                            "18. When I meet people at a party, I am more likely to remember",
                        answers: [
                          "what they looked like.",
                          "what they said about themselves."
                        ],
                        onSelect: model.selectVisVer,
                      ),
                      Item(
                        quiestion: "19. I am more likely to be considered",
                        answers: ["outgoing.", "reserved."],
                        onSelect: model.selectActRef,
                      ),
                      Item(
                        quiestion: "20. For entertainment, I would rather",
                        answers: ["watch television.", "read a book."],
                        onSelect: model.selectVisVer,
                      ),
                      Item(
                        quiestion:
                            "21. The idea of doing homework in groups, with one grade for the entire group,",
                        answers: ["appeals to me.", "does not appeal to me."],
                        onSelect: model.selectActRef,
                      ),
                      Item(
                        quiestion: "22. I tend to picture places I have been",
                        answers: [
                          "easily and fairly accurately.",
                          "with difficulty and without much detail."
                        ],
                        onSelect: model.selectVisVer,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        onPressed: () {
                          model.calculateStyles();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => ConceptsView(),
                            ),
                          );
                        },
                        color: Colors.blue,
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class Item extends StatefulWidget {
  final quiestion, answers, onSelect;

  const Item({Key key, this.quiestion, this.answers, this.onSelect})
      : super(key: key);
  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  var val;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.quiestion),
          ...List.generate(
              widget.answers.length,
              (index) => RadioListTile(
                    title: Text(widget.answers[index]),
                    value: index,
                    groupValue: val,
                    onChanged: (value) {
                      widget.onSelect(index);
                      setState(() {
                        val = index;
                      });
                    },
                  ))
        ],
      ),
    );
  }
}
