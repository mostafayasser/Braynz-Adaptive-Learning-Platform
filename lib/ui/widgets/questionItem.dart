import 'package:flutter/material.dart';

class QuestionItem extends StatefulWidget {
  final quiestion, answers, onSelect, correctAnswer;

  const QuestionItem(
      {Key key,
      this.quiestion,
      this.answers,
      this.onSelect,
      this.correctAnswer})
      : super(key: key);
  @override
  _QuestionItemState createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
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
                      if (index == widget.correctAnswer)
                        widget.onSelect(true);
                      else
                        widget.onSelect(false);
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
