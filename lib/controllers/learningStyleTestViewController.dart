import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/user.dart';

import 'package:graduation_project/services/api/http_api.dart';
import 'package:graduation_project/services/auth/authentication_service.dart';
import 'package:graduation_project/views/conceptsView.dart';

class LearningStyleTestViewController extends BaseNotifier {
  final AuthenticationService auth;
  final HttpApi api;
  LearningStyleTestViewController({NotifierState state, this.api, this.auth})
      : super(state: state);

  int verbal = 0, visual = 0, active = 0, reflective = 0;

  selectVisVer(int index) {
    if (index == 0)
      visual++;
    else
      verbal++;
  }

  selectActRef(int index) {
    if (index == 0)
      active++;
    else
      reflective++;
  }

  Future<bool> calculateStyles(context) async {
    List<String> styles = [];
    if (active > reflective) {
      styles.add("active");
    } else {
      styles.add("reflective");
    }
    if (visual > verbal) {
      styles.add("visual");
    } else {
      styles.add("verbal");
    }
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                styles[0] == "active"
                    ? "Your learning style is:\n\nActive: Learn by trying things\n"
                    : "Your learning style is:\n\nReflective: Learn by thinking things out\n",
              ),
              Text(
                styles[1] == "visual"
                    ? "Visual: Remember what you see"
                    : "Verbal: Prefer written content",
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  color: Color(0xFF3C096C),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ConceptsView(),
                      ),
                    );
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

    bool updated = await api.selectLearningStyle(styles, auth.user);
    User user = auth.user;
    user.learningStyle = styles;
    if (updated) auth.setUser(user: user);
    return updated;
  }
}
