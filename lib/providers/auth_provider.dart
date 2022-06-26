import 'package:example_api/models/user_model.dart';
import 'package:example_api/services/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  set user(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register({String? name, String? email, String? password}) async {
    try {
      await AuthService()
          .register(name: name, email: email, password: password);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getData() async {
    try {
      UserModel user = await AuthService().getData();
      _user = user;
      return user;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> login({String? email, String? password}) async {
    try {
      UserModel user =
          await AuthService().login(email: email, password: password);
      _user = user;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String tokens = user.token as String;
      prefs.setString('token', tokens);
      // print(prefs.getString('token'));
      // const storage = FlutterSecureStorage();
      // const keyToken = 'token';
      // await storage.write(key: keyToken, value: user.token);
      // prefs.setString('token', user.token);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
