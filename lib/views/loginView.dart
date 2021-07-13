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
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/login.png",
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.2,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Welcome Back!",
                        style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Log in to your account",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      CustomTextField(
                        controller: model.emailController,
                        prefixIcon: Icon(
                          Icons.person_outline_rounded,
                        ),
                        hintText: "Enter Email",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: model.passwordController,
                        obscure: true,
                        prefixIcon: Icon(
                          Icons.lock_outline_rounded,
                        ),
                        hintText: "Enter Password",
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35)),
                                color: Theme.of(context).primaryColor,
                                child: Text(
                                  "Login",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
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
