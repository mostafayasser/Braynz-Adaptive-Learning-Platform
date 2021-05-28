import 'package:flutter/material.dart';

class PassedDialog extends StatelessWidget {
  final buttonText, proceedOnPressed;

  const PassedDialog({Key key, this.buttonText, this.proceedOnPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.28,
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
          Text("Congratulations! You have passed the test"),
          SizedBox(
            height: 10,
          ),
          Image.asset(
            "assets/smileIcon.png",
            height: 50,
            width: 50,
            fit: BoxFit.cover,
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
    );
  }
}
