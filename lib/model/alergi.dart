class Alergi {
  int? id;
  String? allergen;
  String? reaction;
  var severity_scale;
  Alergi({this.id, this.allergen, this.reaction, this.severity_scale});
  factory Alergi.fromJson(Map<String, dynamic> obj) {
    return Alergi(
        id: obj['id'],
        allergen: obj['allergen'],
        reaction: obj['reaction'],
        severity_scale: obj['severity_scale']);
  }
}
