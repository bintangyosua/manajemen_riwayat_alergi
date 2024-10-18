class ApiUrl {
  static const String baseUrl = 'http://103.196.155.42/api';
  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listProduk = baseUrl + '/kesehatan/riwayat_alergi';
  static const String createProduk = baseUrl + '/kesehatan/riwayat_alergi';
  static String updateProduk(int id) {
    return baseUrl + '/kesehatan/riwayat_alergi/' + id.toString() + '/update';
  }

  static String showProduk(int id) {
    return baseUrl + '/kesehatan/riwayat_alergi/' + id.toString();
  }

  static String deleteProduk(int id) {
    return baseUrl + '/kesehatan/riwayat_alergi/' + id.toString() + '/delete';
  }
}
