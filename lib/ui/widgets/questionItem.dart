import 'package:flutter/material.dart';
import 'package:graduation_project/models/question.dart';

class QuestionItem extends StatefulWidget {
  final Question question;
  final Function onSelect;

  const QuestionItem({
    Key key,
    this.question,
    this.onSelect,
  }) : super(key: key);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.question.question),
              GestureDetector(
                  child: Icon(
                    Icons.info_outline_rounded,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text(widget.question.hint),
                      ),
                    );
                  })
            ],
          ),
          ...List.generate(
              widget.question.answers.length,
              (index) => RadioListTile(
                    title: Text(widget.question.answers[index]),
                    value: index,
                    groupValue: val,
                    onChanged: (value) {
                      if (index == widget.question.answer)
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
