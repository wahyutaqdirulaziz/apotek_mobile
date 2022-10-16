class UserProfileModel {
  DataUser? data;

  UserProfileModel({this.data});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DataUser.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataUser {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? imageUrl;
  String? createdAt;

  DataUser(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.imageUrl,
      this.createdAt});

  DataUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    imageUrl = json['image_url'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['image_url'] = this.imageUrl;
    data['created_at'] = this.createdAt;
    return data;
  }
}
