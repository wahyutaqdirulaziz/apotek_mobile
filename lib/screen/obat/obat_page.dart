import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

import '../../untilities/colors.dart';

class ObatPage extends StatefulWidget {
  const ObatPage({Key? key}) : super(key: key);

  @override
  State<ObatPage> createState() => _ObatPageState();
}

class _ObatPageState extends State<ObatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: textTheme),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Obat Page",
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
                    color: textTheme,
                    fontWeight: FontWeight.w600,
                    fontSize: 17))),
      ),
      body: SafeArea(
        child: Column(),
      ),
    );
  }
}
