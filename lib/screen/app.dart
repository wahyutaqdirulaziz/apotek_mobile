import 'package:apotek_ku/screen/home/apotek/apotek_page.dart';
import 'package:apotek_ku/screen/profile/profile_page.dart';
import 'package:apotek_ku/untilities/colors.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/user/user_bloc.dart';
import 'home/apotek/apotek_homepage.dart';
import 'home/home_page/home_page.dart';
import 'obat/obat_page.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int _selectedIndex = 0;
  TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ApotekHomePage(),
    BlocProvider(
      create: (context) => UserBloc()..add(GetProfile()),
      child: ProfilePage(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedFontSize: 8,
        selectedFontSize: 8,
        elevation: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/Home.png",
              color: _selectedIndex == 0 ? greenTheme : Colors.grey,
              width: 20,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/Hospital.png",
              color: _selectedIndex == 1 ? greenTheme : Colors.grey,
              width: 20,
            ),
            label: 'Apotek',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/User.png",
              color: _selectedIndex == 2 ? greenTheme : Colors.grey,
              width: 20,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: greenTheme,
        onTap: _onItemTapped,
      ),
    );
  }
}
