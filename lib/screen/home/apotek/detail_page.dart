import 'dart:typed_data';
import 'package:apotek_ku/blocs/detailapotek/detailapotek_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../untilities/colors.dart';

class DetailApotekPage extends StatefulWidget {
  int id;
  String nama;
  String alamat;
  String no;
  String gambar;
  String? no_izin;
  double lat;
  double long;
  String keterangan;
  DetailApotekPage(
      {Key? key,
      required this.id,
      required this.nama,
      required this.alamat,
      required this.no,
      required this.gambar,
      this.no_izin,
      required this.lat,
      required this.long,
      required this.keterangan})
      : super(key: key);

  @override
  State<DetailApotekPage> createState() => _DetailApotekPageState();
}

class _DetailApotekPageState extends State<DetailApotekPage> {
  bool show = false;
  Set<Marker> markers = Set();
  final Uri _url = Uri.parse('https://api.whatsapp.com/send?+6287763305916');
  @override
  void initState() {
    // TODO: implement initState

    addMarkers();

    super.initState();
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  final Completer<GoogleMapController> _controller = Completer();

  addMarkers() async {
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/orang.png",
    );
    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(widget.lat, widget.long),
      zoom: 14.4746,
    );
    markers.add(Marker(
      //add start location marker
      markerId: MarkerId(_kGooglePlex.target.toString()),
      position: _kGooglePlex.target, //position of marker
      infoWindow: InfoWindow(
        onTap: () {
          launchGoogleMaps(widget.lat, widget.long);
        },
        //popup info
        title: '${widget.nama}',
      ),
      icon: markerbitmap, //Icon for Marker
    ));
  }

  void launchWaze(double lat, double lng) async {
    var url = Uri.parse('waze://?ll=${lat.toString()},${lng.toString()}');
    var fallbackUrl = Uri.parse(
        'https://waze.com/ul?ll=${lat.toString()},${lng.toString()}&navigate=yes');
    try {
      bool launched = await launchUrl(url);
      if (!launched) {
        await launchUrl(fallbackUrl);
      }
    } catch (e) {
      await launchUrl(fallbackUrl);
    }
  }

  void launchGoogleMaps(double lat, double lng) async {
    var url =
        Uri.parse('google.navigation:q=${lat.toString()},${lng.toString()}');
    var fallbackUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${lat.toString()},${lng.toString()}');
    try {
      bool launched = await launchUrl(url);
      if (!launched) {
        await launchUrl(fallbackUrl);
      }
    } catch (e) {
      await launchUrl(fallbackUrl);
    }
  }

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
        title: Text("Apotek Detail",
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
                    color: textTheme,
                    fontWeight: FontWeight.w600,
                    fontSize: 17))),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              mapType: MapType.normal,
              markers: markers,
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.lat, widget.long),
                zoom: 14.4746,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          show
              ? BlocProvider(
                  create: (context) =>
                      DetailapotekBloc()..add(ApotekDetailFetch(id: widget.id)),
                  child: BlocBuilder<DetailapotekBloc, DetailapotekState>(
                    builder: (context, state) {
                      if (state is ApotekDetailLoadedState) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 70),
                            height: 250,
                            width: double.infinity,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return cardObat(context,
                                      state.data[index]!.namaObat, widget.nama);
                                }),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                )
              : SizedBox(),
          Container(
            margin: const EdgeInsets.all(10),
            height: 135,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),

                  offset: const Offset(1, 1), // changes position of shadow
                ),
              ],
            ),
            child: Row(children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage("${widget.gambar}"))),
                width: MediaQuery.of(context).size.width / 2.7,
              ),
              Container(
                margin: const EdgeInsets.only(left: 8, top: 10, bottom: 10),
                width: MediaQuery.of(context).size.width / 1.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 18, right: 18),
                      child: Text(widget.nama,
                          maxLines: 1,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                color: textTheme,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 18, right: 18),
                      child: Text(widget.alamat,
                          maxLines: 1,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                color: greenTheme,
                                fontWeight: FontWeight.w400,
                                fontSize: 10),
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 18, right: 18),
                      child: Text(widget.no_izin ?? "NO123455",
                          maxLines: 1,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                color: greenTheme,
                                fontWeight: FontWeight.w400,
                                fontSize: 10),
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 18, right: 18, bottom: 17),
                      child: Text("${widget.no} ${widget.keterangan}",
                          maxLines: 4,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                color: subtextTheme,
                                fontWeight: FontWeight.w400,
                                fontSize: 10),
                          )),
                    ),
                  ],
                ),
              )
            ]),
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.height / 17,
                    child: ElevatedButton(
                        // ignore: sort_child_properties_last
                        child: Row(
                          children: [
                            Icon(Icons.whatsapp),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Chat",
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12))),
                          ],
                        ),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(greenTheme),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: greenTheme)))),
                        onPressed: () {
                          _launchUrl();
                        }),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.9,
                    height: MediaQuery.of(context).size.height / 17,
                    child: ElevatedButton(
                        // ignore: sort_child_properties_last
                        child: Text("Tampilkan Lokasi dan Obat",
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12))),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(greenTheme),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: greenTheme)))),
                        onPressed: () {
                          setState(() {
                            if (show) {
                              show = false;
                            } else {
                              show = true;
                            }
                          });
                        }),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Container cardObat(BuildContext context, nama, nama_apotek) {
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
                child: Text("1800 km",
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
          child: Text("${nama}",
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
          child: Text("Apotek ${nama_apotek}",
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
