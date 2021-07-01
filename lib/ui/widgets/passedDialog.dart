import 'package:flutter/material.dart';

class PassedDialog extends StatelessWidget {
  final buttonText,
      proceedOnPressed,
      backButtonText,
      wrongAnswersNums,
      score,
      conceptFinalTest;

  const PassedDialog({
    Key key,
    this.buttonText,
    this.proceedOnPressed,
    this.backButtonText,
    this.wrongAnswersNums,
    this.score,
    this.conceptFinalTest = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(wrongAnswersNums);
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
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
          Text("Your score is $score%"),
          SizedBox(
            height: 10,
          ),
          if (wrongAnswersNums != null && wrongAnswersNums.isNotEmpty)
            Text("Wrong questions numbers are "),
          if (wrongAnswersNums != null && wrongAnswersNums.isNotEmpty)
            Wrap(
              children: List.generate(
                wrongAnswersNums.length,
                (index) => Text(
                  index != wrongAnswersNums.length - 1
                      ? "${wrongAnswersNums[index].toString()},"
                      : "${wrongAnswersNums[index].toString()}",
                ),
              ),
            ),
          if (wrongAnswersNums != null && wrongAnswersNums.isNotEmpty)
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                  "Back to $backButtonText",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (!conceptFinalTest) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
