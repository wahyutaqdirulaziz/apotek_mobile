import 'package:apotek_ku/screen/onbording_page/onbording_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../blocs/user/user_bloc.dart';
import '../../../untilities/colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String textbotton = "Register";
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nomorController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _nomorController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserRegisterLoadingState) {
          setState(() {
            textbotton = "Please Wait...";
          });
        }

        if (state is UserRegisterLoadedState) {
          setState(() {
            textbotton = "Register";
          });
          Get.offAll(OnbordingPage());
        }

        if (state is UserRegisterErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Silahkan Mengisi data dengan Benar !")));
          setState(() {
            textbotton = "Register";
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: IconThemeData(color: textTheme),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text("Sign Up",
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          color: textTheme,
                          fontWeight: FontWeight.w600,
                          fontSize: 17))),
            ),
            body: ListView(children: [
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
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
                                  color: greenTheme,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                prefixIcon: Image.asset(
                                  "assets/User.png",
                                  color: filltextTheme,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                filled: true,
                                hintStyle: TextStyle(
                                    color: filltextTheme,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                                hintText: "Enter Your Name",
                                fillColor: fillTheme,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      BorderSide(width: 1, color: fillTheme),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      BorderSide(width: 1, color: greenTheme),
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                prefixIcon: Image.asset(
                                  "assets/sms.png",
                                  color: filltextTheme,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                filled: true,
                                hintStyle: TextStyle(
                                    color: filltextTheme,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                                hintText: "Enter Email Adress",
                                fillColor: fillTheme,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      BorderSide(width: 1, color: fillTheme),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      BorderSide(width: 1, color: greenTheme),
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: _nomorController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                prefixIcon: Image.asset(
                                  "assets/sms.png",
                                  color: filltextTheme,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                filled: true,
                                hintStyle: TextStyle(
                                    color: filltextTheme,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                                hintText: "Enter Phone Number",
                                fillColor: fillTheme,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      BorderSide(width: 1, color: fillTheme),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      BorderSide(width: 1, color: greenTheme),
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                prefixIcon: Image.asset(
                                  "assets/lock.png",
                                  color: filltextTheme,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                filled: true,
                                hintStyle: TextStyle(
                                    color: filltextTheme,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                                hintText: "Enter Your password",
                                fillColor: fillTheme,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      BorderSide(width: 1, color: fillTheme),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      BorderSide(width: 1, color: greenTheme),
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 17,
                            child: ElevatedButton(
                                child: Text(textbotton,
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14))),
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            greenTheme),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: greenTheme)))),
                                onPressed: () {
                                  _registrasi(context);
                                }),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ]));
      },
    );
  }

  void _registrasi(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<UserBloc>(context).add(
        UserRegistrasi(
            name: _nameController.text,
            email: _emailController.text,
            nomor: _nomorController.text,
            password: _passwordController.text),
      );
    }
  }
}
