import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation_project/services/api/http_api.dart';
import 'package:graduation_project/services/auth/authentication_service.dart';

class RegisterationViewController extends BaseNotifier {
  final AuthenticationService auth;
  final HttpApi api;
  RegisterationViewController({
    this.api,
    this.auth,
    NotifierState state,
  }) : super(state: state);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var studyTime;
  List<String> studyTimes = ["Morning", "Evening"];
  register() async {
    setBusy();
    await auth.signUp({
      "email": emailController.text,
      "studyTime": studyTime,
      "password": passwordController.text
    });
    if (auth.userLoged) {
      setIdle();
    } else {
      setError();
    }
  }
}
