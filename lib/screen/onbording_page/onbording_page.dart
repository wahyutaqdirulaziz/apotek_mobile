import 'package:apotek_ku/screen/auth_page/login_page/login_page.dart';
import 'package:apotek_ku/untilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth_page/register_page/register_page.dart';

class OnbordingPage extends StatefulWidget {
  const OnbordingPage({Key? key}) : super(key: key);

  @override
  State<OnbordingPage> createState() => _OnbordingPageState();
}

class _OnbordingPageState extends State<OnbordingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/Vector.png",
              color: greenTheme,
              width: 80,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Apotek Kuy",
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                  color: greenTheme, fontWeight: FontWeight.w700, fontSize: 14),
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          Text(
            "Let’s get started!",
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                  color: textTheme, fontWeight: FontWeight.w700, fontSize: 22),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Login to enjoy the features we’ve \n provided, and stay healthy!",
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
                    color: subtextTheme,
                    fontWeight: FontWeight.w300,
                    fontSize: 16)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.4,
            height: MediaQuery.of(context).size.height / 17,
            child: ElevatedButton(
                child: Text("Login",
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14))),
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(greenTheme),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: greenTheme)))),
                onPressed: () {
                  Get.to(LoginPage());
                }),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.4,
            height: MediaQuery.of(context).size.height / 17,
            child: ElevatedButton(
                child: Text("Sign Up",
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            color: greenTheme,
                            fontWeight: FontWeight.w600,
                            fontSize: 14))),
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(greenTheme),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: greenTheme)))),
                onPressed: () {
                  Get.to(RegisterPage());
                }),
          )
        ],
      ),
    );
  }
}
