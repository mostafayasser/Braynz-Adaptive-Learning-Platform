import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/services/api/http_api.dart';
import 'package:graduation_project/services/auth/authentication_service.dart';

class LoginViewController extends BaseNotifier {
  final AuthenticationService auth;
  final HttpApi api;
  LoginViewController({NotifierState state, this.api, this.auth})
      : super(state: state);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Future<bool> login() async {
    setBusy();
    await auth.login(
        email: emailController.text, password: passwordController.text);
    if (auth.userLoged) {
      return true;
    } else {
      setError();
    }
    return false;
  }
}
