import 'dart:async';

import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/controllers/loginViewController.dart';
import 'package:graduation_project/views/conceptsView.dart';
import 'package:graduation_project/views/loginView.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/services/api/api.dart';
import 'package:ui_utils/ui_utils.dart';

const _inactivityTimeout = Duration(seconds: 10);
Timer _keepAliveTimer;

void _keepAlive(bool visible, LoginViewController model) async {
  _keepAliveTimer?.cancel();
  if (visible) {
    _keepAliveTimer = null;
    bool inSession = await model.api.userInSession(model.auth.user);

    if (!inSession) {
      model.api.startSession(model.auth.user);
    } else {
      var time = await model.api.lastSessionStartTime(model.auth.user);
      if (time != 0 && DateTime.now().millisecondsSinceEpoch - time > 7200000) {
        await model.api.endSession(model.auth.user);
        model.api.startSession(model.auth.user);
      }
    }
    print("visible");
  } else {
    _keepAliveTimer = Timer(_inactivityTimeout, () async {
      print("timeout");
      bool inSession = await model.api.userInSession(model.auth.user);
      if (inSession) model.api.endSession(model.auth.user);
      print("timeout");
    });
  }
}

class _KeepAliveObserver extends WidgetsBindingObserver {
  final LoginViewController model;
  _KeepAliveObserver(this.model);
  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _keepAlive(true, model);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _keepAlive(false, model); // Conservatively set a timer on all three
        break;
    }
  }
}

/// Must be called only when app is visible, and exactly once
void startKeepAlive(LoginViewController model) {
  assert(_keepAliveTimer == null);
  _keepAlive(true, model);
  WidgetsBinding.instance.addObserver(_KeepAliveObserver(model));
}

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FocusWidget(
      child: Scaffold(
        //appBar: AppBar(),
        body: BaseWidget<LoginViewController>(
            initState: (m) =>
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  /* bool firstTime = Preference.getBool("firstTime") ?? true;
                  if (firstTime) {
                    startKeepAlive(m);
                    Preference.setBool("firstTime", false);
                  } */
                  startKeepAlive(m);
                  if (m.auth.user != null) {
                    bool inSession = await m.api.userInSession(m.auth.user);
                    if (!inSession) {
                      m.api.startSession(m.auth.user);
                    }
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ConceptsView(),
                      ),
                    );
                  } else {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LoginView(),
                      ),
                    );
                  }
                }),
            model: LoginViewController(
              api: Provider.of<Api>(context),
              auth: Provider.of(context),
            ),
            builder: (context, model, child) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[],
                ),
              );
            }),
      ),
    );
  }
}
