import 'package:apotek_ku/blocs/apotek/apotek_bloc.dart';
import 'package:apotek_ku/screen/home/apotek/detail_page.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../untilities/colors.dart';

class ApotekHomePage extends StatefulWidget {
  const ApotekHomePage({Key? key}) : super(key: key);

  @override
  State<ApotekHomePage> createState() => _ApotekPageState();
}

class _ApotekPageState extends State<ApotekHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: const IconThemeData(color: textTheme),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Apotek Page",
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
                    color: textTheme,
                    fontWeight: FontWeight.w600,
                    fontSize: 17))),
      ),
      body: Column(children: [
        const SizedBox(
          height: 15,
        ),
        BlocBuilder<ApotekBloc, ApotekState>(
          builder: (context, state) {
            if (state is ApotekLoadingState) {}
            if (state is ApotekLoadedState) {
              return Expanded(
                child: ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(DetailApotekPage(
                            nama: state.data[index].namaApotek!,
                            alamat: state.data[index].alamat!,
                            no: state.data[index].telepon!,
                            gambar: state.data[index].gambar!,
                          ));
                        },
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
                                      image: NetworkImage(
                                          state.data[index].gambar!))),
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
                                    child: Text(state.data[index].namaApotek!,
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
                                    child: Text(state.data[index].alamat!,
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
                                    child: Text(
                                        "Kimia Farma Apotek merupakan perusahaan farmasi dengan jaringan apotek terbesar & penyedia layanan kesehatan di Indonesia.",
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
      ]),
    );
  }
}
