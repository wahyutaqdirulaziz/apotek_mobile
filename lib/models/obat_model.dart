class ObatModel {
  List<Data>? data;

  ObatModel({
    this.data,
  });

  ObatModel.fromJson(Map<String, dynamic> json) {
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
  int? idApotek;
  String? namaObat;
  String? jenis;
  String? keterangan;
  String? createdAt;

  Data(
      {this.id,
      this.idApotek,
      this.namaObat,
      this.jenis,
      this.keterangan,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idApotek = json['id_apotek'];
    namaObat = json['nama_obat'];
    jenis = json['jenis'];
    keterangan = json['keterangan'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_apotek'] = this.idApotek;
    data['nama_obat'] = this.namaObat;
    data['jenis'] = this.jenis;
    data['keterangan'] = this.keterangan;
    data['created_at'] = this.createdAt;
    return data;
  }
}
