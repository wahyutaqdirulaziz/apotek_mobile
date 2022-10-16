class Detail_apotik_model {
  List<Apotek>? apotek;
  List<DataObat>? dataObat;

  Detail_apotik_model({this.apotek, this.dataObat});

  Detail_apotik_model.fromJson(Map<String, dynamic> json) {
    if (json['apotek'] != null) {
      apotek = <Apotek>[];
      json['apotek'].forEach((v) {
        apotek!.add(new Apotek.fromJson(v));
      });
    }
    if (json['data_obat'] != null) {
      dataObat = <DataObat>[];
      json['data_obat'].forEach((v) {
        dataObat!.add(new DataObat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.apotek != null) {
      data['apotek'] = this.apotek!.map((v) => v.toJson()).toList();
    }
    if (this.dataObat != null) {
      data['data_obat'] = this.dataObat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Apotek {
  int? id;
  String? namaApotek;
  String? email;
  String? nomorIzinApotek;
  String? telepon;
  String? gambar;
  String? alamat;
  String? deskripsi;
  String? lat;
  String? long;
  String? createdAt;

  Apotek(
      {this.id,
      this.namaApotek,
      this.email,
      this.nomorIzinApotek,
      this.telepon,
      this.gambar,
      this.alamat,
      this.deskripsi,
      this.lat,
      this.long,
      this.createdAt});

  Apotek.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaApotek = json['nama_apotek'];
    email = json['email'];
    nomorIzinApotek = json['nomor_izin_apotek'];
    telepon = json['telepon'];
    gambar = json['gambar'];
    alamat = json['alamat'];
    deskripsi = json['deskripsi'];
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
    data['alamat'] = this.alamat;
    data['deskripsi'] = this.deskripsi;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class DataObat {
  int? id;
  String? namaObat;
  String? jenis;
  String? keterangan;

  DataObat({this.id, this.namaObat, this.jenis, this.keterangan});

  DataObat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaObat = json['nama_obat'];
    jenis = json['jenis'];
    keterangan = json['keterangan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_obat'] = this.namaObat;
    data['jenis'] = this.jenis;
    data['keterangan'] = this.keterangan;
    return data;
  }
}
