import 'package:apotek_ku/screen/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../onbording_page/onbording_page.dart';
import '../splash_page/splash_page.dart';
import 'login_page/login_page.dart';

class LoginStatus extends StatefulWidget {
  const LoginStatus({Key? key}) : super(key: key);

  @override
  State<LoginStatus> createState() => _LoginStatusState();
}

class _LoginStatusState extends State<LoginStatus> {
  void initState() {
    // TODO: implement initState
    ceklogin();
    super.initState();
  }

  ceklogin() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      print("tokennull");
      print("token ${token}");
      Get.to(OnbordingPage());
    } else {
      print("asik");
      // ignore: use_build_context_synchronously
      Get.to(AppPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
