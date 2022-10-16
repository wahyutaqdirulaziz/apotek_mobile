class ApotekModel {
  List<Data>? data;

  ApotekModel({
    this.data,
  });

  ApotekModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Data {
  int? id;
  String? namaApotek;
  String? email;
  String? nomorIzinApotek;
  String? telepon;
  String? gambar;
  String? deskripsi;
  String? alamat;
  String? lat;
  String? long;
  String? createdAt;

  Data(
      {this.id,
      this.namaApotek,
      this.email,
      this.nomorIzinApotek,
      this.telepon,
      this.gambar,
      this.deskripsi,
      this.alamat,
      this.lat,
      this.long,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaApotek = json['nama_apotek'];
    email = json['email'];
    nomorIzinApotek = json['nomor_izin_apotek'];
    telepon = json['telepon'];
    gambar = json['gambar'];
    deskripsi = json['deskripsi'];
    alamat = json['alamat'];
    lat = json['lat'];
    long = json['long'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_apotek'] = this.namaApotek;
    data['email'] = this.email;
    data['nomor_izin_apotek'] = this.nomorIzinApotek;
    data['telepon'] = this.telepon;
    data['gambar'] = this.gambar;
    data['deskripsi'] = this.deskripsi;
    data['alamat'] = this.alamat;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['created_at'] = this.createdAt;
    return data;
  }
}
