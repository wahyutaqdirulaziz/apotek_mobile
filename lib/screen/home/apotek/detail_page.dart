import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../untilities/colors.dart';

class DetailApotekPage extends StatefulWidget {
  String nama;
  String alamat;
  String no;
  String gambar;
  DetailApotekPage(
      {Key? key,
      required this.nama,
      required this.alamat,
      required this.no,
      required this.gambar})
      : super(key: key);

  @override
  State<DetailApotekPage> createState() => _DetailApotekPageState();
}

class _DetailApotekPageState extends State<DetailApotekPage> {
  bool show = false;
  Set<Marker> markers = Set();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    addMarkers();
  }

  final Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-5.1245699939923, 119.50486074342),
    zoom: 14.4746,
  );

  void whatsAppOpen() async {
    await FlutterLaunch.launchWhatsapp(
        phone: "${widget.no}", message: "Hello ${widget.nama}");
  }

  addMarkers() async {
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/orang.png",
    );

    markers.add(Marker(
      //add start location marker
      markerId: MarkerId(_kGooglePlex.target.toString()),
      position: _kGooglePlex.target, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: markerbitmap, //Icon for Marker
    ));
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
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          show
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 70),
                    height: 250,
                    width: double.infinity,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return cardObat(context);
                        }),
                  ),
                )
              : SizedBox(),
          Container(
            margin: const EdgeInsets.all(10),
            height: 130,
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
                      margin: const EdgeInsets.only(
                          left: 18, right: 18, bottom: 17),
                      child: Text("${widget.no}",
                          maxLines: 5,
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
                          whatsAppOpen();
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
                        child: Text("Tampilkan Obat",
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14))),
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

Container cardObat(BuildContext context) {
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
          child: Text("Obat Paracetamol",
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
