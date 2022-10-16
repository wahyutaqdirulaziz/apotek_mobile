import 'dart:convert';

import 'package:apotek_ku/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_profile_model.dart';
import '../untilities/urlbase.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<UserModel> login(
      {required String email, required String password}) async {
    Response response = await _dio.post(
      '${baseUrl}/api/login',
      data: {
        'email': email,
        'password': password,
      },
    );
    final prefs = await SharedPreferences.getInstance();

    print("username :${email}");
    print("password :${password}");
    // Prints the raw data returned by the server
    print('User Info: ${response.data}');

    // Parsing the raw JSON data to the User class
    try {
      if (response.statusCode == 200) {
        prefs.setString('token', response.data['data']["access_token"]);
        prefs.setInt('id', response.data['data']["id"]);
        return UserModel.fromJson(response.data);
      }

      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      print("inieror : ${e}");
      return UserModel.fromJson(response.data);
    }
  }

  Future register(
      {required String name,
      required String email,
      required String number,
      required String password}) async {
    Response response = await _dio.post(
      '${baseUrl}/api/register',
      data: {
        'name': name,
        'email': email,
        'phone_number': number,
        'password': password,
      },
    );

    print("ini ${response.statusCode}");
    try {
      if (response.statusCode == 201) {
        print("registrasi success");
      }

      print("registrasi gagal");
    } on DioError catch (e) {
      print("inieror : ${e}");
    }
  }

  Future<UserProfileModel> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
     final user_id = prefs.getInt('id');
    Response response = await _dio.get(
      '${baseUrl}/api/get_profil/${user_id}',
      options: Options(
        headers: {
          "Authorization": "Bearer ${token}",
        },
      ),
    );

    // Parsing the raw JSON data to the User class
    try {
      if (response.statusCode == 200) {
        return UserProfileModel.fromJson(response.data);
      }

      return UserProfileModel.fromJson(response.data);
    } on DioError catch (e) {
      print("inieror : ${e}");
      return UserProfileModel.fromJson(response.data);
    }
  }
}
