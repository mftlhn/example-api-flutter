import 'dart:convert';
import 'package:example_api/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // kalo testing di browser
  // String baseUrl = 'http://127.0.0.1:8000/api';

  // kalo testing di emulator
  String baseUrl = 'http://10.0.2.2:8000/api';
  String? token;

  Future<bool> register({String? name, String? email, String? password}) async {
    var url = '$baseUrl/register';
    var header = {'Content-Type': 'application/json'};
    var body = jsonEncode({'name': name, 'email': email, 'password': password});
    var response = await http.post(Uri.parse(url), headers: header, body: body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<UserModel> login({String? email, String? password}) async {
    var url = '$baseUrl/login';
    var header = {'Content-Type': 'application/json'};
    var body = jsonEncode({'email': email, 'password': password});
    var response = await http.post(Uri.parse(url), headers: header, body: body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      UserModel userModel = UserModel.fromJson(data['data']);
      userModel.token = 'Bearer ' + data['token'];
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('token', userModel.token as String);
      return userModel;
    } else {
      var message = jsonDecode(response.body)['meta'];
      throw Exception(message['message']);
    }
  }

  Future<UserModel> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

    var url = '$baseUrl/get-data';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': '$token'
    };
    var response = await http.get(Uri.parse(url), headers: header);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data);
      return user;
    } else {
      var message = jsonDecode(response.body)['meta'];
      throw Exception(message['message']);
    }
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    var url = '$baseUrl/logout';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '$token'
    };
    var response = await http.post(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      // print(prefs);
    }
  }
}
