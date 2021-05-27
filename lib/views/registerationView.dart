import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/controllers/registerationViewController.dart';
import 'package:graduation_project/services/api/api.dart';
import 'package:graduation_project/ui/widgets/dropDownList.dart';

import 'package:graduation_project/ui/widgets/txtFieldCustom.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';

class RegisterationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FocusWidget(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: BaseWidget<RegisterationViewController>(
            model: RegisterationViewController(
              auth: Provider.of(context),
              api: Provider.of<Api>(context),
            ),
            builder: (context, model, child) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CustomTextField(
                      controller: model.emailController,
                      hintText: "Enter Email",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      controller: model.passwordController,
                      hintText: "Enter Password",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropDownList(
                      hint: "Study time",
                      items: model.studyTimes,
                      onChange: (value) {
                        model.studyTime = value;
                        model.setState();
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    model.busy
                        ? CircularProgressIndicator()
                        : RaisedButton(
                            onPressed: () {
                              model.register();
                            },
                            child: Text("Register"),
                          ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
