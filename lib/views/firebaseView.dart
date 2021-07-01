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
              /* store.collection("topics").doc("9").set({
                "id": 9,
                "material": {
                  "pdf": [
                    {
                      "name": "Functions in C++",
                      "rate": 0.0,
                      "url":
                          "http://www.compsci.hunter.cuny.edu/~sweiss/resources/functions.pdf"
                    },
                    {
                      "name": "Summary of functions in C++",
                      "rate": 0.0,
                      "url":
                          "https://www.tutorialspoint.com/cplusplus/pdf/cpp_functions.pdf"
                    },
                  ],
                  "video": [
                    {
                      "name": "Functions in C++",
                      "rate": 0.0,
                      "url": "https://www.youtube.com/watch?v=WqukJuBnLQU"
                    },
                    {
                      "name": "Summary of functions in C++",
                      "rate": 0.0,
                      "url": "https://www.youtube.com/watch?v=fQ_CBGVfGbM"
                    },
                  ],
                },
                "name": "Variables and Data types",
                "preTestID": 0,
                "postTestID": 0,
              }); */
              store
                  .collection("tests")
                  .doc("13")
                  .collection("question9")
                  .doc("9")
                  .set({
                "answer": 2,
                "answers": [
                  "1@2@",
                  "1@2@1@",
                  "1@1@2@",
                  "1@2@2@",
                ],
                "hint": "for (initialization; condition; increase) statement;",
                "question":
                    "9. Find the output of below program.\nint main()\n{\nfor(int i=1;i<=2;i++)\n{\nfor(int j=i;j<=2;j++)\ncout<<i<<@;\n}\n}",
                "topicName": "Nested loops",
                "topicID": 3
              });
            },
            child: Text("submit")),
      ),
    );
  }
}

/* 
store
                  .collection("tests")
                  .doc("2")
                  .collection("question3")
                  .doc("3")
                  .set({
                "answer": 0,
                "answers": [
                  "12345",
                  "1234",
                  "5",
                  "6",
                ],
                "hint":
                    "Every time increase statement is called the loop excutes",
                "question":
                    "3. What is the output of C Program.? \nint main()\n{\nint k;\nfor(k=1; k <= 5; k++);\n{\ncout <<k;\n}\nreturn 0;\n}",
                "topicName": "For Loop",
                "topicID": 1
              });
 */

/* store
                  .collection("tests")
                  .doc("2")
                  .collection("question3")
                  .doc("3")
                  .set({
                "answer": 1,
                "answers": [
                  "exp3",
                  "exp1",
                  "both",
                  "all experssions",
                ],
                "hint": "for (initialization; condition; increase) statement;",
                "question":
                    "3. In the following loop construct, which one is executed only once always. \n for(exp1; exp2; exp3)",
                "topicName": "For Loop",
                "topicID": 1
              }); */

/* store
                  .collection("tests")
                  .doc("3")
                  .collection("question1")
                  .doc("1")
                  .set({
                "answer": 3,
                "answers": [
                  "252525",
                  "272727",
                  "Error",
                  "252627",
                ],
                "hint": "while (expression) statement",
                "question":
                    "1. What is the output of C++ Program.?\nint main()\n{\nint a=25;\nwhile(a <= 27)\n{\ncout <<a;\na++;\n}\nreturn 0;\n}",
                "topicName": "While Loop",
                "topicID": 2
              }); */

/* store
                  .collection("tests")
                  .doc("3")
                  .collection("question2")
                  .doc("2")
                  .set({
                "answer": 0,
                "answers": [
                  "32",
                  "30",
                  "33",
                  "Error",
                ],
                "hint": "do statement while (condition);",
                "question":
                    "2. What is the output of Program?\nint main()\n{\nint a=32;\ndo\n{\ncout <<a;\na++;\n}\nwhile(a <= 30);\nreturn 0;\n}",
                "topicName": "While Loop",
                "topicID": 2
              }); */

/* store
                  .collection("tests")
                  .doc("4")
                  .collection("question3")
                  .doc("3")
                  .set({
                "answer": 2,
                "answers": [
                  "1\n2\n3\n4\n5\n",
                  "1\n22\n333\n4444\n55555\n",
                  "1\n222\n33333\n4444444\n555555555",
                  "None of the above",
                ],
                "hint": "for (initialization; condition; increase) statement;",
                "question":
                    "Find the output of below program.\n int main()\n{\nint i,j,k;\nfor(i=1;i<=5;i++)\n{\nfor(j=5;j>i;j--)\ncout<<' ';\nfor(k=1;k<2*i;k++)\ncout<<i;\ncout<<endl;\n}\nreturn 0;\n}",
                "topicName": "Nested loops",
                "topicID": 3
              }); */

/* store
                  .collection("tests")
                  .doc("4")
                  .collection("question3")
                  .doc("3")
                  .set({
                "answer": 0,
                "answers": [
                  "**********\n**********\n**********\n**********\n",
                  "*\n**\n***\n*****\n",
                  "**********\n*********\n********\n*******\n",
                  "None of the above",
                ],
                "hint": "for (initialization; condition; increase) statement;",
                "question":
                    "Find the output of below program.\nint main()\n{\nint i,j;\nfor(i=1;i<=4;i++)\n{\nfor(j=1;j<=10;j++)\ncout<<'*';\ncout<<endl;\n}\nreturn 0;\n}",
                "topicName": "Nested loops",
                "topicID": 3
              }); */

/* store
                  .collection("tests")
                  .doc("4")
                  .collection("question1")
                  .doc("1")
                  .set({
                "answer": 2,
                "answers": [
                  "1@2@",
                  "1@2@1@",
                  "1@1@2@",
                  "1@2@2@",
                ],
                "hint": "for (initialization; condition; increase) statement;",
                "question":
                    "Find the output of below program.\nint main()\n{\nfor(int i=1;i<=2;i++)\n{\nfor(int j=i;j<=2;j++)\ncout<<i<<@;\n}\n}",
                "topicName": "Nested loops",
                "topicID": 3
              }); */

/* store
                  .collection("tests")
                  .doc("7")
                  .collection("question2")
                  .doc("2")
                  .set({
                "answer": 2,
                "answers": [
                  "too hot",
                  "too cold",
                  "just right",
                  "too hot too cold just right",
                ],
                "hint": "",
                "question":
                    "2. The following code displays ___________.\ndouble temperature = 50;\nif (temperature >= 100)\ncout << \"too hot\";\nelse if (temperature <= 40)\ncout << \"too cold\";\nelse\ncout << \"just right\";",
                "topicName": "if, else and switch statements",
                "topicID": 6
              }); */

/* store
                  .collection("tests")
                  .doc("7")
                  .collection("question3")
                  .doc("3")
                  .set({
                "answer": 1,
                "answers": [
                  "1",
                  "2",
                  "3",
                  "23",
                ],
                "hint": "",
                "question":
                    "3. what is the value of x :\nint x;\char y = \"w\";\nswitch (d) {\ncase x: x = 1; break;\ncase w: x = 2;break;\ndefault: x = 3;\n}",
                "topicName": "if, else and switch statements",
                "topicID": 6
              }); */

/* store
                  .collection("tests")
                  .doc("8")
                  .collection("question2")
                  .doc("2")
                  .set({
                "answer": 1,
                "answers": [
                  "a",
                  "3",
                  "5",
                  "a[3]",
                ],
                "hint": "",
                "question":
                    "1. In the statement a[3] = 5, which of the following is the index value?",
                "topicName": "Arrays",
                "topicID": 7
              }); */

/* store
                  .collection("tests")
                  .doc("8")
                  .collection("question2")
                  .doc("2")
                  .set({
                "answer": 1,
                "answers": [
                  "bool array1[10];",
                  "double array2[20,0];",
                  "char array3[30];",
                  "double array4[7];",
                ],
                "hint": "",
                "question":
                    "2. Which of the following array declarations is invalid?",
                "topicName": "Arrays",
                "topicID": 7
              }); */

/* store
                  .collection("tests")
                  .doc("8")
                  .collection("question3")
                  .doc("3")
                  .set({
                "answer": 0,
                "answers": [
                  "int ABC[5]= {100,100,100,100,100};",
                  "int ABC[]= {5,100};",
                  "int ABC[5]= {5,100};",
                  "int[5] ABC= {100,100,100,100,100};",
                ],
                "hint": "",
                "question":
                    "3. Which of the following statement Declare an array called ABC of 5 elements of type int and initialize all the elements to 100?",
                "topicName": "Arrays",
                "topicID": 7
              }); */

/* store
                  .collection("tests")
                  .doc("9")
                  .collection("question1")
                  .doc("1")
                  .set({
                "answer": 0,
                "answers": [
                  "7.9",
                  "9.2",
                  "7.3",
                  "0.5",
                ],
                "hint": "",
                "question":
                    "1. Examine the following:\ndouble values[][] =\n{ {1.2, 9.0, 3.2},\n{9.2, 0.5, -1.2},\n{7.3, 7.9, 4.8} } ;\nwhat is in values[2][1] ?",
                "topicName": "2D Arrays",
                "topicID": 8
              }); */

/*  store
                  .collection("tests")
                  .doc("9")
                  .collection("question3")
                  .doc("3")
                  .set({
                "answer": 1,
                "answers": [
                  "3",
                  "4",
                  "2",
                  "a[2][0]",
                ],
                "hint": "",
                "question":
                    "3. How many columns does a have if it is created as follows\nint[][] a = {{2, 4, 6, 8}, {1, 2, 3, 4}};?",
                "topicName": "2D Arrays",
                "topicID": 8
              }); */

/* store
                  .collection("tests")
                  .doc("10")
                  .collection("question1")
                  .doc("1")
                  .set({
                "answer": 0,
                "answers": [
                  "5 10",
                  "5 6",
                  "5 5",
                  "5 2",
                ],
                "hint": "Return statement in functions gives back a value",
                "question":
                    "1. what is the output of the program? \nint test(int);\nvoid main()\n{\nint x=1, z;\nz=test(x);\ncout<<z;\nx++;\nz=test(x);\ncout<<z;\n}\nint test(int y)\n{\nreturn(y*5);\n}",
                "topicName": "Functions",
                "topicID": 9
              }); */

/* store
                  .collection("tests")
                  .doc("10")
                  .collection("question2")
                  .doc("2")
                  .set({
                "answer": 2,
                "answers": [
                  "with arguments and no return value",
                  "without arguments and return value",
                  "with arguments and with return value",
                  "without arguments and no return value",
                ],
                "hint": "Return statement in functions gives back a value",
                "question":
                    "2. x= display(x,y);\nwhat type of function is this statement belong to?",
                "topicName": "Functions",
                "topicID": 9
              }); */
