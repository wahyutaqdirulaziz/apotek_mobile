class UserModel {
  String? message;
  Null? errors;
  int? statusCode;
  Data? data;

  UserModel({this.message, this.errors, this.statusCode, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errors = json['errors'];
    statusCode = json['status_code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['errors'] = this.errors;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? accessToken;
  String? tokenType;

  Data(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.accessToken,
      this.tokenType});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    return data;
  }
}
