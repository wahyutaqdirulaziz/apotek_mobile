import 'dart:async';

import 'package:apotek_ku/screen/onbording_page/onbording_page.dart';
import 'package:apotek_ku/untilities/colors.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => OnbordingPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenTheme,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/Vector.png"),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Apotek Kuy",
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 17),
              ),
            )
          ],
        ),
      )),
    );
  }
}
