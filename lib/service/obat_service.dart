import 'dart:convert';

import 'package:apotek_ku/models/obat_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../untilities/urlbase.dart';

class ObatService {
  final Dio _dio = Dio();

  Future<ObatModel> getObat() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    Response response = await _dio.get(
      '${baseUrl}/api/list_obat',
      options: Options(
        headers: {
          "Authorization": "Bearer ${token}",
        },
      ),
    );

    // Parsing the raw JSON data to the User class
    try {
      if (response.statusCode == 200) {
        return ObatModel.fromJson(response.data);
      }

      return ObatModel.fromJson(response.data);
    } on DioError catch (e) {
      print("inieror : ${e}");
      return ObatModel.fromJson(response.data);
    }
  }
}
