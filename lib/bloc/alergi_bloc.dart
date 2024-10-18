import 'dart:convert';
import 'package:manajemen_riwayat_alergi/helpers/api.dart';
import 'package:manajemen_riwayat_alergi/helpers/api_url.dart';
import 'package:manajemen_riwayat_alergi/model/alergi.dart';

class AlergiBloc {
  static Future<List<Alergi>> getAlergis() async {
    String apiUrl = ApiUrl.listAlergi;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listAlergi = (jsonObj as Map<String, dynamic>)['data'];
    List<Alergi> alergis = [];
    for (int i = 0; i < listAlergi.length; i++) {
      alergis.add(Alergi.fromJson(listAlergi[i]));
    }
    return alergis;
  }

  static Future addAlergi({required Alergi alergi}) async {
    String apiUrl = ApiUrl.createAlergi;
    var body = {
      "allergen": alergi.allergen,
      "reaction": alergi.reaction,
      "severity_scale": alergi.severity_scale.toString()
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateAlergi({required Alergi alergi}) async {
    String apiUrl = ApiUrl.updateAlergi(alergi.id!);
    var body = {
      "allergen": alergi.allergen,
      "reaction": alergi.reaction,
      "severity_scale": alergi.severity_scale.toString()
    };
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteAlergi({int? id}) async {
    String apiUrl = ApiUrl.deleteAlergi(id!);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
