import 'package:graduation_project/views/loginView.dart';
import 'package:graduation_project/views/registerationView.dart';

class Routes {
  static const loginViewRoute = "login";
  static const registerationViewRoute = "register";
  static final routes = {
    loginViewRoute: (ctx) => LoginView(),
    registerationViewRoute: (ctx) => RegisterationView(),
  };
}
