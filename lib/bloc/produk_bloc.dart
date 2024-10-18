import 'dart:convert';
import 'package:manajemen_riwayat_alergi/helpers/api.dart';
import 'package:manajemen_riwayat_alergi/helpers/api_url.dart';
import 'package:manajemen_riwayat_alergi/model/produk.dart';

class ProdukBloc {
  static Future<List<Produk>> getProduks() async {
    String apiUrl = ApiUrl.listProduk;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listProduk = (jsonObj as Map<String, dynamic>)['data'];
    List<Produk> produks = [];
    for (int i = 0; i < listProduk.length; i++) {
      produks.add(Produk.fromJson(listProduk[i]));
    }
    return produks;
  }

  static Future addProduk({required Produk produk}) async {
    String apiUrl = ApiUrl.createProduk;
    var body = {
      "allergen": produk.allergen,
      "reaction": produk.reaction,
      "severity_scale": produk.severity_scale.toString()
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateProduk({required Produk produk}) async {
    String apiUrl = ApiUrl.updateProduk(produk.id!);
    var body = {
      "allergen": produk.allergen,
      "reaction": produk.reaction,
      "severity_scale": produk.severity_scale.toString()
    };
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteProduk({int? id}) async {
    String apiUrl = ApiUrl.deleteProduk(id!);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
