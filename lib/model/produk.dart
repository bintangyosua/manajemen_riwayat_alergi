class Produk {
  int? id;
  String? allergen;
  String? reaction;
  var severity_scale;
  Produk({this.id, this.allergen, this.reaction, this.severity_scale});
  factory Produk.fromJson(Map<String, dynamic> obj) {
    return Produk(
        id: obj['id'],
        allergen: obj['allergen'],
        reaction: obj['reaction'],
        severity_scale: obj['severity_scale']);
  }
}
