import 'package:apotek_ku/blocs/obat/obat_bloc.dart';
import 'package:apotek_ku/screen/home/apotek/apotek_page.dart';
import 'package:apotek_ku/screen/obat/all_obat.dart';
import 'package:apotek_ku/screen/obat/obat_page.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../blocs/apotek/apotek_bloc.dart';
import '../../../untilities/colors.dart';
import '../apotek/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 1;
  String? _currentAddress = "lokasi";
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

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    context.read<ApotekBloc>()..add(ApotekFetch(keyword: "",page: page));
    context.read<ObatBloc>()..add(ObatFetch());
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    // TODO: implement initState
    _getCurrentPosition();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SmartRefresher(
        enablePullDown: true,
        header: WaterDropMaterialHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Susah Cari Apotek ?",
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
                        children: [
                          Icon(
                            Icons.fmd_good,
                            color: greenTheme,
                            size: 15,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "${_currentAddress}",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  color: subtextTheme,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 22),
                  child: Image.asset("assets/Notification.png"),
                )
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 17, left: 17),
            //   child: TextField(
            //     decoration: InputDecoration(
            //         contentPadding: const EdgeInsets.all(10),
            //         prefixIcon: Image.asset(
            //           "assets/Search.png",
            //           color: const Color.fromARGB(255, 187, 187, 187),
            //         ),
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(15.0),
            //         ),
            //         filled: true,
            //         hintStyle: const TextStyle(
            //             color: filltextTheme,
            //             fontSize: 14,
            //             fontWeight: FontWeight.w300),
            //         hintText: "Search apotek, drugs, articles...",
            //         fillColor: const Color.fromARGB(255, 244, 244, 244),
            //         enabledBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(15.0),
            //           borderSide: const BorderSide(
            //             width: 1,
            //             color: Color.fromARGB(255, 244, 244, 244),
            //           ),
            //         ),
            //         focusedBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(15.0),
            //           borderSide: const BorderSide(
            //             width: 1,
            //             color: const Color.fromARGB(255, 244, 244, 244),
            //           ),
            //         )),
            //   ),
            // ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20),
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.height / 24,
                          child: ElevatedButton(
                              // ignore: sort_child_properties_last
                              child: Text("Call admin",
                                  style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12))),
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
                                              BorderRadius.circular(10.0),
                                          side: const BorderSide(
                                              color: greenTheme)))),
                              onPressed: () {
                                launchUrl(Uri.parse("tel:08776305916"));
                              }),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    "assets/obat.png",
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Apotik Terdekat",
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              color: textTheme,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        )),
                    GestureDetector(
                      onTap: () {
                        Get.to(ApotekPage());
                      },
                      child: Text("Show all",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                color: greenTheme,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          )),
                    )
                  ]),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<ApotekBloc, ApotekState>(
              buildWhen: (previous, current) {
                // return true/false to determine whether or not
                // to rebuild the widget with state
                return (current is ApotekLoadedState);
              },
              builder: (context, state) {
                if (state is ApotekLoadingState) {}

                if (state is ApotekLoadedState) {
                  return Container(
                    margin: const EdgeInsets.only(left: 20),
                    height: 250,
                    width: double.infinity,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(DetailApotekPage(
                                id: state.data[index].id!,
                                nama: state.data[index].namaApotek!,
                                alamat: state.data[index].alamat!,
                                no: state.data[index].telepon!,
                                gambar: state.data[index].gambar!,
                                lat: double.parse(state.data[index].lat!),
                                long: double.parse(state.data[index].long!),
                                keterangan: state.data[index].deskripsi!,
                              ));
                            },
                            child: cardapotik(
                                context,
                                state.data[index].namaApotek,
                                state.data[index].alamat,
                                state.data[index].deskripsi,
                                state.data[index].gambar),
                          );
                        }),
                  );
                } else {
                  return Container(
                      margin: const EdgeInsets.only(left: 20),
                      height: 250,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Apotek Kuy",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                color: greenTheme,
                                fontWeight: FontWeight.w200,
                                fontSize: 12),
                          ),
                        ),
                      ));
                }
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Products Obat Populer",
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              color: textTheme,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        )),
                    InkWell(
                      onTap: () {
                        Get.to(AllObatPage());
                      },
                      child: Text("Show all",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                color: greenTheme,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          )),
                    )
                  ]),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<ObatBloc, ObatState>(
              buildWhen: (previous, current) {
                return (current is ObatLoadedState);
              },
              builder: (context, state) {
                if (state is ObatLoadedState) {
                  return Container(
                    margin: const EdgeInsets.only(left: 20),
                    height: 250,
                    width: double.infinity,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return cardObat(context, state.data[index].namaObat!,
                              state.data[index].jenis);
                        }),
                  );
                } else {
                  return Container(
                      margin: const EdgeInsets.only(left: 20),
                      height: 250,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Apotek Kuy",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                color: greenTheme,
                                fontWeight: FontWeight.w200,
                                fontSize: 12),
                          ),
                        ),
                      ));
                }
              },
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20),
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
                          "Cari Dokter Terdekat ?",
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.height / 24,
                          child: ElevatedButton(
                              // ignore: sort_child_properties_last
                              child: Text("Call Admin",
                                  style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12))),
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
                                              BorderRadius.circular(10.0),
                                          side: const BorderSide(
                                              color: greenTheme)))),
                              onPressed: () {
                                launchUrl(Uri.parse("tel:08776305916"));
                              }),
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
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      )),
    );
  }

  Container cardObat(BuildContext context, nama, jenis) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 25,
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 5,
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    "assets/obatkotak.png",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("${jenis}",
                      maxLines: 1,
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            color: greenTheme,
                            fontWeight: FontWeight.w400,
                            fontSize: 10),
                      )),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 18, right: 18),
            child: Text("Obat ${nama}",
                maxLines: 1,
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                      color: textTheme,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                )),
          ),
          Container(
            margin: const EdgeInsets.only(left: 18, right: 18, bottom: 17),
            child: Text("Apotek Kimia Farma",
                maxLines: 1,
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                      color: subtextTheme,
                      fontWeight: FontWeight.w400,
                      fontSize: 10),
                )),
          ),
        ],
      ),
    );
  }

  Container cardapotik(BuildContext context, nama, alamat, keterangan, gambar) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 25,
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 5,
            child: Stack(
              children: [
                Center(
                  child: Image.network(
                    gambar,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.fmd_good,
                          color: greenTheme,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(alamat,
                            maxLines: 1,
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  color: greenTheme,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 8),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 17),
            child: Text(nama,
                maxLines: 1,
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                      color: textTheme,
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                )),
          ),
          Container(
            margin: const EdgeInsets.only(left: 18, right: 18, bottom: 17),
            child: Text(keterangan,
                maxLines: 2,
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                      color: subtextTheme,
                      fontWeight: FontWeight.w400,
                      fontSize: 10),
                )),
          ),
        ],
      ),
    );
  }
}
