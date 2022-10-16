import 'package:apotek_ku/blocs/obat/obat_bloc.dart';
import 'package:apotek_ku/screen/auth_page/login_status.dart';
import 'package:apotek_ku/screen/splash_page/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'blocs/apotek/apotek_bloc.dart';
import 'blocs/user/user_bloc.dart';
import 'screen/onbording_page/onbording_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ApotekBloc()..add(ApotekFetch()),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => ObatBloc()..add(ObatFetch()),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Apotek Kuy',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: LoginStatus(),
      ),
    );
  }
}
