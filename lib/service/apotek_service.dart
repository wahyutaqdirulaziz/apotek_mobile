import 'dart:convert';

import 'package:apotek_ku/models/apotek_detail_model.dart';
import 'package:apotek_ku/models/apotek_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../untilities/urlbase.dart';

class ApotekService {
  final Dio _dio = Dio();

  Future<ApotekModel> getApotek({int? page}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    Response response = await _dio.get(
      '${baseUrl}/api/apotek?page=${page}',
      options: Options(
        headers: {
          "Authorization": "Bearer ${token}",
        },
      ),
    );

    // Parsing the raw JSON data to the User class
    try {
      if (response.statusCode == 200) {
        return ApotekModel.fromJson(response.data);
      }

      return ApotekModel.fromJson(response.data);
    } on DioError catch (e) {
      print("inieror : ${e}");
      return ApotekModel.fromJson(response.data);
    }
  }

  Future<ApotekModel> searchApotek({String? keyword}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    Response response = await _dio.get(
      '${baseUrl}/api/search_apotek/${keyword}',
      options: Options(
        headers: {
          "Authorization": "Bearer ${token}",
        },
      ),
    );

    // Parsing the raw JSON data to the User class
    try {
      if (response.statusCode == 200) {
        return ApotekModel.fromJson(response.data);
      }

      return ApotekModel.fromJson(response.data);
    } on DioError catch (e) {
      print("inieror : ${e}");
      return ApotekModel.fromJson(response.data);
    }
  }

  Future<Detail_apotik_model> getDetailApotek({int? id}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    Response response = await _dio.get(
      '${baseUrl}/api/detail_apotek/${id}',
      options: Options(
        headers: {
          "Authorization": "Bearer ${token}",
        },
      ),
    );

    // Parsing the raw JSON data to the User class
    try {
      if (response.statusCode == 200) {
        return Detail_apotik_model.fromJson(response.data);
      }

      return Detail_apotik_model.fromJson(response.data);
    } on DioError catch (e) {
      print("inieror : ${e}");
      return Detail_apotik_model.fromJson(response.data);
    }
  }
}
