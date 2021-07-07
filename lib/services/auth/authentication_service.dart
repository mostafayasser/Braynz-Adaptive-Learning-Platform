import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:graduation_project/models/user.dart';
import 'package:graduation_project/services/api/http_api.dart';
import 'package:graduation_project/services/preference/preference.dart';
import 'package:logger/logger.dart';

class AuthenticationService {
  final HttpApi api;

  static User _user;
  User get user => _user;

  AuthenticationService({this.api}) {
    loadUser;
  }

  /*
   * authenticate user by his phone number and password
   */
  Future<bool> login(
      {@required String email,
      @required String password,
      String macAddress}) async {
    try {
      _user = await api.login(email: email, password: password);

      if (_user != null) {
        saveUser(user: _user);
        return true;
      }
    } catch (e) {
      Logger().e(e);
      return false;
    }
    return false;
  }

  bool setUser({@required User user}) {
    try {
      _user = user;

      if (_user != null) {
        saveUser(user: _user);
        return true;
      }
    } catch (e) {
      Logger().e(e);
      return false;
    }
    return false;
  }
  /* 
  User user;

    if (response['user'] != null) {
      user = User.fromJson(response);
    }

    final token = user.token;

    if (token == null) {
      return null;
    }

    await Preference.setString(PrefKeys.token, token);

    if (user != null) {
      return user;
    } else {
      return null;
    } */

  Future<bool> signUp(Map<String, dynamic> param) async {
    User user;
    try {
      user = await api.signUp(param: param);
      if (user != null) {
        _user = user;
        Logger().i(_user.toJson());
        Preference.clear();
        saveUser(user: _user);
      }
      return user != null ? true : false;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  /*
   * change authenticated user password
   * return false if not authenticated
   */
  // Future<bool> changeUserPassword({@required BuildContext context, @required String oldPassword, @required String newPassword}) async {
  //   if (user != null) {
  //     // return await api.changePassword(context: context, phone: _user.username, oldPassword: oldPassword, newPassword: newPassword, token: _user.token);
  //   } else {
  //     return null;
  //   }
  // }

  /*
   *check if user is authenticated 
   */
  bool get userLoged => Preference.getBool(PrefKeys.userLogged) ?? false;

  /*
   *save user in shared prefrences 
   */
  saveUser({User user}) {
    Preference.setBool(PrefKeys.userLogged, true);
    Preference.setString(PrefKeys.userData, json.encode(user.toJson()));
    print(json.decode(Preference.getString(PrefKeys.userData)));
  }

  /*
   * load the user info from shared prefrence if existed to be used in the service   
   */
  Future<void> get loadUser async {
    if (userLoged) {
      _user =
          User.fromJson(json.decode(Preference.getString(PrefKeys.userData)));
      print(_user.toJson());
      print('\n\n\n\n');
    }
  }

  /*
   * refresh the user access token and update it in shared prefrence   
   */
  // Future<bool> get refreshToken async => await api.refreshToken();

  /*
   * signout the user from the app and return to the login screen   
   */
  Future<void> get signOut async {
    await Preference.remove(PrefKeys.userData);
    await Preference.remove(PrefKeys.userLogged);
    _user = null;
  }

  /*  Future<bool> changePassowrd(BuildContext context,
      {Map<String, dynamic> param}) async {
    User user;
    try {
      user = await api.changePassword(context, param: param);
    } catch (e) {}

    if (user != null) {
      _user = user;
      saveUser(user: user);
      Logger().i(_user.toJson());
      return true;
    } else {
      return false;
    }
  } */

  /* updateUserInfo(BuildContext context, {Map<String, dynamic> body}) async {
    try {
      final UserInfo userInfo =
          await api.updateUserInfo(context, body: body, userId: _user.user.id);
      if (userInfo != null) {
        _user.user = userInfo;
        Logger().i(_user.toJson());
        saveUser(user: _user);
      }
      return user != null ? true : false;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  } */

  logout() {
    _user = null;
    Preference.clear();
  }

  /* sendResetEmail(context, {String email}) async {
    var res = await api.sendResetEmail(context, email);
    if (res == true) {
      return true;
    } else {
      return false;
    }
  } */

  /* resetPassword(BuildContext context, {Map<String, dynamic> body}) async {
    UserInfo res = await api.resetPassword(context, body: body);
    if (res != null) {
      return true;
    } else {
      return false;
    */ //}
  // }

}
