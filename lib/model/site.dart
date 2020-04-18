import 'dart:convert';

//class Site{
//  int idsite;
//  String nama;
//  String keterangan;
//
//  Site ({
//    this.idsite=0,
//    this.nama,
//    this.keterangan
//  });
//
//  factory Site.fromJson(Map<String, dynamic> map) {
//    return Site(
//        idsite: map["idsite"],
//        nama: map["nama"],
//        keterangan: map["keterangan"]
//    );
//  }
//
//  Map<String, dynamic> toJson(){
//    return {
//      "idsite": idsite,
//      "nama": nama,
//      "keterangan":keterangan
//    };
//  }
//
//  @override
//  String toString() {
//    return 'Site{idsite: $idsite, nama: $nama, keterangan: $keterangan}';
//  }
//
//}
//
//List<Site> siteFromJson(String jsonData){
//  final data = json.decode(jsonData );
//  return List<Site>.from(data.map((item)=>Site.fromJson(item)));
//}
//
//String siteToJson(Site data) {
//  final jsonData = data.toJson();
//  return json.encode(jsonData);
//}



class Site {
  int idsite;
  String nama;
  String keterangan;

  Site({this.idsite = 0, this.nama, this.keterangan});

  factory Site.fromJson(Map<String, dynamic> map) {
    return Site(
        idsite: map["idsite"], nama: map["nama"], keterangan: map["keterangan"]);
  }

  Map<String, dynamic> toJson() {
    return {"idsite": idsite, "nama": nama, "keterangan": keterangan};
  }

  @override
  String toString() {
    return '{idsite: $idsite, nama: $nama, keterangan: $keterangan}';
  }
}

List<Site> siteFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Site>.from(data.map((item) => Site.fromJson(item)));
}

String siteToJson(Site data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}