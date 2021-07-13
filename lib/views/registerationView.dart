import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/controllers/registerationViewController.dart';
import 'package:graduation_project/services/api/api.dart';

import 'package:graduation_project/ui/widgets/txtFieldCustom.dart';
import 'package:graduation_project/views/learningStyleTestView.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';

class RegisterationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FocusWidget(
      child: Scaffold(
        body: BaseWidget<RegisterationViewController>(
            model: RegisterationViewController(
              auth: Provider.of(context),
              api: Provider.of<Api>(context),
            ),
            builder: (context, model, child) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Let's Get Started!",
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Create an account to get all features",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    CustomTextField(
                      controller: model.nameController,
                      hintText: "Enter Your First name",
                      prefixIcon: Icon(Icons.person_outline_rounded),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    CustomTextField(
                      controller: model.ageController,
                      hintText: "Enter your age",
                      keyboardType: TextInputType.number,
                      prefixIcon: Icon(Icons.height),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    CustomTextField(
                      controller: model.emailController,
                      hintText: "Enter Email",
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    CustomTextField(
                      controller: model.passwordController,
                      hintText: "Enter Password",
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    model.busy
                        ? CircularProgressIndicator()
                        : Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.07,
                            child: RaisedButton(
                              onPressed: () async {
                                bool done = await model.register();
                                if (done) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          LearningStyleTestPage(),
                                    ),
                                  );
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35)),
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                "Register",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
