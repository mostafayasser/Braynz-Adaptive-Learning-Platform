import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/controllers/loginViewController.dart';
import 'package:graduation_project/helpers/routes/route.dart';
import 'package:graduation_project/services/api/api.dart';
import 'package:graduation_project/ui/widgets/txtFieldCustom.dart';
import 'package:graduation_project/views/conceptsView.dart';
import 'package:graduation_project/views/learningStyleTestView.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FocusWidget(
      child: Scaffold(
        body: BaseWidget<LoginViewController>(
            model: LoginViewController(
              auth: Provider.of(context),
              api: Provider.of<Api>(context),
            ),
            builder: (context, model, child) {
              return Center(
                child: SingleChildScrollView(
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
                      model.busy
                          ? CircularProgressIndicator()
                          : RaisedButton(
                              onPressed: () async {
                                bool logged = await model.login();
                                if (logged) {
                                  if (model.auth.user.learningStyle.isEmpty)
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            LearningStyleTestPage(),
                                      ),
                                    );
                                  else
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => ConceptsView(),
                                      ),
                                    );
                                }
                              },
                              child: Text("Login"),
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(Routes.registerationViewRoute);
                        },
                        child: Text("Don\'t have an account? Register"),
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
