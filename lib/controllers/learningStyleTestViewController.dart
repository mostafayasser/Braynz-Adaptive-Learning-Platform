import 'package:base_notifier/base_notifier.dart';
import 'package:graduation_project/models/user.dart';

import 'package:graduation_project/services/api/http_api.dart';
import 'package:graduation_project/services/auth/authentication_service.dart';

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

  calculateStyles() async {
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
    bool updated = await api.selectLearningStyle(styles, auth.user);
    User user = auth.user;
    user.learningStyle = styles;
    if (updated) auth.setUser(user: user);
  }
}
