import 'dart:convert';

import 'package:apotek_ku/models/apotek_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../untilities/urlbase.dart';

class ApotekService {
  final Dio _dio = Dio();

  Future<ApotekModel> getApotek() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    Response response = await _dio.get(
      '${baseUrl}/api/apotek',
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
}
