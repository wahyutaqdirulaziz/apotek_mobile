import 'package:apotek_ku/untilities/colors.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/obat/obat_bloc.dart';

class AllObatPage extends StatefulWidget {
  const AllObatPage({Key? key}) : super(key: key);

  @override
  State<AllObatPage> createState() => _AllObatPageState();
}

class _AllObatPageState extends State<AllObatPage> {
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
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 17, left: 17),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  prefixIcon: Image.asset(
                    "assets/Search.png",
                    color: const Color.fromARGB(255, 187, 187, 187),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  hintStyle: const TextStyle(
                      color: filltextTheme,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                  hintText: "Search apotek, drugs, articles...",
                  fillColor: const Color.fromARGB(255, 244, 244, 244),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color.fromARGB(255, 244, 244, 244),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      width: 1,
                      color: const Color.fromARGB(255, 244, 244, 244),
                    ),
                  )),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          BlocBuilder<ObatBloc, ObatState>(
            builder: (context, state) {
              if (state is ObatLoadedState) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 130,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),

                                  offset: const Offset(
                                      1, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                          "assets/obatkotak.png",
                                        ))),
                                width: MediaQuery.of(context).size.width / 2.7,
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 8, top: 10, bottom: 10),
                                width: MediaQuery.of(context).size.width / 1.9,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 18, right: 18),
                                      child: Text(state.data[index].namaObat!,
                                          maxLines: 1,
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                                color: textTheme,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          )),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 18, right: 18),
                                      child: Text("jenis : ${state.data[index].jenis!}",
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
                                      child: Text(state.data[index].keterangan!,
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
                        );
                      }),
                );
              } else {
                return SizedBox();
              }
            },
          )
        ],
      ),
    );
  }
}
