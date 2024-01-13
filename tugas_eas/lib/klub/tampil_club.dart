import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas_eas/controller/ApiController.dart';
import 'package:tugas_eas/klub/edit_klub.dart';
import 'package:tugas_eas/widget/spasi.dart';
import 'package:tugas_eas/widget/text.dart';
import 'package:http/http.dart' as http;

class TampilKlub extends StatefulWidget {
  const TampilKlub({super.key});

  @override
  State<TampilKlub> createState() => _TampilKlubState();
}

class _TampilKlubState extends State<TampilKlub> {
  var _dataClub = [];
  var keyword = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getDataClub();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      appBar: AppBar(
        backgroundColor: Color(0xFF004225),
        title: MyText(
          text: "DATA KLUB",
          ukuran: 20,
          ketebalan: FontWeight.w900,
          warna: Color(0xFFF5F5DC),
        ),
      ),
      // drawer: drawerRoute(context),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            MyTextField(keyword),
            Spasi(kebawah: 15),
            Expanded(
              child: _dataClub.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF004225),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _dataClub.length,
                      itemBuilder: (context, int index) {
                        return _dataKlub(
                          context: context,
                          id_klub: _dataClub[index]["id_klub"],
                          nama_klub: _dataClub[index]["nama_klub"],
                          tanggal_berdiri: _dataClub[index]["tanggal_berdiri"],
                          kondisi_klub: _dataClub[index]["kondisi_klub"],
                          kota_klub: _dataClub[index]["kota_klub"],
                          peringkat: _dataClub[index]["peringkat"],
                          harga_klub: _dataClub[index]["hargaKlub"],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Container _dataKlub(
      {context,
      id_klub,
      nama_klub,
      tanggal_berdiri,
      kondisi_klub,
      kota_klub,
      peringkat,
      harga_klub}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(15),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          color: Color(0xFF004225),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 5,
              offset: Offset(0, 5),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.sports_soccer_outlined,
                color: Color(0xFFF5F5DC),
              ),
              Spasi(kesamping: 5),
              MyText(
                text: "$nama_klub",
                ukuran: 20,
                ketebalan: FontWeight.w600,
                warna: Color(0xFFF5F5DC),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.calendar_month,
                color: Color(0xFFF5F5DC),
              ),
              Spasi(kesamping: 5),
              MyText(
                text: "$tanggal_berdiri",
                ukuran: 15,
                ketebalan: FontWeight.w400,
                warna: Color(0xFFF5F5DC),
              ),
            ],
          ),
          Spasi(kebawah: 2),
          Divider(
            color: Color(0xFFF5F5DC),
            thickness: 1.5,
          ),
          Spasi(kebawah: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_city,
                    color: Color(0xFFF5F5DC),
                  ),
                  Spasi(kesamping: 5),
                  MyText(
                    text: "Kota $kota_klub",
                    ukuran: 15,
                    ketebalan: FontWeight.w400,
                    warna: Color(0xFFF5F5DC),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.accessibility_new_sharp,
                    color: Color(0xFFF5F5DC),
                  ),
                  Spasi(kesamping: 5),
                  MyText(
                    text: "Kondisi $kondisi_klub",
                    ukuran: 15,
                    ketebalan: FontWeight.w400,
                    warna: Color(0xFFF5F5DC),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.sell,
                    color: Color(0xFFF5F5DC),
                  ),
                  Spasi(kesamping: 5),
                  MyText(
                    text: "Harga: Rp.$harga_klub",
                    ukuran: 15,
                    ketebalan: FontWeight.w400,
                    warna: Color(0xFFF5F5DC),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.bar_chart,
                    color: Color(0xFFF5F5DC),
                  ),
                  Spasi(kesamping: 5),
                  MyText(
                    text: "Peingkat $peringkat",
                    ukuran: 15,
                    ketebalan: FontWeight.w400,
                    warna: Color(0xFFF5F5DC),
                  ),
                ],
              ),
            ],
          ),
          Spasi(kebawah: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditClub(
                          idKlub: id_klub,
                          namaKlub: nama_klub,
                          tanggalBerdiri: tanggal_berdiri,
                          kondisiKlub: kondisi_klub,
                          kotaKlub: kota_klub,
                          peringkat: peringkat,
                          hargaKlub: harga_klub,
                        ),
                      ),
                    ).then((value) {
                      if (value != null) {
                        _getDataClub();
                      }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit_square,
                        color: Color(0xFF004225),
                        size: 20,
                      ),
                      Spasi(kesamping: 5),
                      MyText(
                        text: "Edit",
                        ukuran: 15,
                        ketebalan: FontWeight.w600,
                        warna: Color(0xFF004225),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF5F5DC),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Spasi(kesamping: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _deleteClub(id_klub);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete_forever,
                        color: Color(0xFF004225),
                        size: 23,
                      ),
                      Spasi(kesamping: 3),
                      MyText(
                        text: "Hapus",
                        ukuran: 15,
                        ketebalan: FontWeight.w600,
                        warna: Color(0xFF004225),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF5F5DC),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _getDataClub() async {
    final response = await http.post(
      Uri.parse(ApiController.getApi()),
      body: {
        "aksi": "tampilKlubBola",
      },
    );

    setState(() {
      _dataClub = jsonDecode(response.body);
    });
  }

  _deleteClub(id_klub) async {
    await http.post(
      Uri.parse(ApiController().api),
      body: {
        "aksi": "hapusKlubBola",
        "idKlub": id_klub,
      },
    );
    _getDataClub();
    final snackbar = SnackBar(
      backgroundColor: Colors.white,
      content: MyText(
        text: "Berhasil Menghapus Data",
        warna: Color(0xFF004225),
        ketebalan: FontWeight.w600,
        ukuran: 15,
      ),
      action: SnackBarAction(
        textColor: Color(0xFF004225),
        label: 'Tutup',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  _searchClub(String keywords) async {
    final response = await http.post(
      Uri.parse(ApiController().api),
      body: {
        "aksi": "cariKlubBola",
        "keywords": keywords,
      },
    );
    setState(() {
      _dataClub = jsonDecode(response.body);
    });
    // print(jsonDecode(response.body));
  }

  TextField MyTextField(controller) {
    return TextField(
      onChanged: (String values) {
        if (values.isEmpty) {
          _getDataClub();
        } else {
          _searchClub(values);
        }
      },
      controller: controller,
      style: GoogleFonts.poppins(
        color: Color(0xFF004225),
      ),
      decoration: InputDecoration(
        hintText: "Masukkan keyword pencarian",
        hintStyle: TextStyle(color: Color(0xFF004225)),
        prefixIcon: Icon(Icons.search, color: Color(0xFF004225)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF004225),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF004225),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
    );
  }
}
