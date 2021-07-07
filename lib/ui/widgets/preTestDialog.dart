import 'package:flutter/material.dart';

class StartTestDialog extends StatelessWidget {
  final yesOnPressed, noOnPressed, message;

  const StartTestDialog({
    Key key,
    this.yesOnPressed,
    this.noOnPressed,
    this.message,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 3, offset: Offset(0, 0))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Would you like to take a $message?"),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                color: Colors.grey,
                child: Text(
                  "Skip",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => noOnPressed(),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                color: Colors.blue,
                child: Text(
                  "Yes",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => yesOnPressed(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
