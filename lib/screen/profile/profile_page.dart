import 'package:apotek_ku/blocs/user/user_bloc.dart';
import 'package:apotek_ku/screen/onbording_page/onbording_page.dart';
import 'package:apotek_ku/untilities/colors.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _currentAddress;
  Position? _currentPosition;

// permission

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
// endpermisiion

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        // ${place.street},
        _currentAddress =
            '${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('token');
    Get.off(OnbordingPage());
  }

  @override
  void initState() {
    // TODO: implement initState
    _getCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserProfileLoadedState) {
          return Scaffold(
            body: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(state.data.imageUrl!),
                          child: const Align(
                              alignment: Alignment.bottomRight,
                              child: const CircleAvatar(
                                  radius: 10,
                                  backgroundColor: greenTheme,
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 15,
                                  ))),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 18, right: 18, top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(state.data.name!,
                                  maxLines: 1,
                                  style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                        color: textTheme,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17),
                                  )),
                              Text(
                                state.data.email!,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                      color: textTheme,
                                      fontWeight: FontWeight.w200,
                                      fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 18, left: 18),
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: containerTheme,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Cari Apotek Terdekat ?",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    color: textTheme,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17),
                              ),
                            ),
                            Text(
                              "Apotek Kuy Solusinya",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    color: textTheme,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.fmd_good,
                                  color: greenTheme,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Lokasi Anda",
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                            color: textTheme,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 8),
                                      ),
                                    ),
                                    Text(
                                      "${_currentAddress}",
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                            color: textTheme,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 8),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        "assets/orang.png",
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 18, right: 18, top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text("Nomor",
                          maxLines: 1,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                color: textTheme,
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text(state.data.phoneNumber!,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                color: subtextTheme,
                                fontWeight: FontWeight.w200,
                                fontSize: 12),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Email",
                          maxLines: 1,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                color: textTheme,
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text(state.data.email!,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                color: subtextTheme,
                                fontWeight: FontWeight.w200,
                                fontSize: 12),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Alamat",
                          maxLines: 1,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                color: textTheme,
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text("${_currentAddress}",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                color: subtextTheme,
                                fontWeight: FontWeight.w200,
                                fontSize: 12),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 18,
                    child: ElevatedButton(
                        // ignore: sort_child_properties_last
                        child: Text("Logout",
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
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: greenTheme)))),
                        onPressed: () {
                          logout();
                        }),
                  ),
                ),
              ],
            )),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text(
                "Loading ....",
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      color: greenTheme,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
