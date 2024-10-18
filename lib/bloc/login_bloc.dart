import 'dart:convert';
import 'package:manajemen_riwayat_alergi/helpers/api.dart';
import 'package:manajemen_riwayat_alergi/helpers/api_url.dart';
import 'package:manajemen_riwayat_alergi/model/login.dart';

class LoginBloc {
  static Future<Login> login({String? email, String? password}) async {
    String apiUrl = ApiUrl.login;
    var body = {"email": email, "password": password};
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return Login.fromJson(jsonObj);
  }
}
