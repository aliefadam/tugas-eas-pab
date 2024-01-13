import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas_eas/controller/ApiController.dart';
import 'package:tugas_eas/supporter/edit_supporter.dart';
import 'package:tugas_eas/widget/spasi.dart';
import 'package:tugas_eas/widget/text.dart';
import 'package:http/http.dart' as http;

class TampilSupporter extends StatefulWidget {
  const TampilSupporter({super.key});

  @override
  State<TampilSupporter> createState() => _TampilSupporterState();
}

class _TampilSupporterState extends State<TampilSupporter> {
  var _dataSupporter = [];
  var keyword = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getDataSupporter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      appBar: AppBar(
        backgroundColor: Color(0xFF004225),
        title: MyText(
          text: "DATA SUPPORTER",
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
              child: _dataSupporter.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF004225),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _dataSupporter.length,
                      itemBuilder: (context, int index) {
                        return _dataSupporterItem(
                          context: context,
                          id_supporter: _dataSupporter[index]["id_supporter"],
                          nama_supporter: _dataSupporter[index]
                              ["nama_supporter"],
                          alamat: _dataSupporter[index]["alamat"],
                          tanggal_daftar: _dataSupporter[index]
                              ["tanggal_daftar"],
                          no_telephone: _dataSupporter[index]["no_telephone"],
                          foto: _dataSupporter[index]["foto"],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Container _dataSupporterItem(
      {context,
      id_supporter,
      nama_supporter,
      alamat,
      tanggal_daftar,
      no_telephone,
      foto}) {
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
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Color(0xFFF5F5DC),
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    "${ApiController.getUploadPath()}$foto",
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
              Spasi(kesamping: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Color(0xFFF5F5DC),
                      ),
                      Spasi(kesamping: 5),
                      MyText(
                        text: "$nama_supporter",
                        ukuran: 20,
                        ketebalan: FontWeight.w600,
                        warna: Color(0xFFF5F5DC),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_city,
                        color: Color(0xFFF5F5DC),
                      ),
                      Spasi(kesamping: 5),
                      MyText(
                        text: "$alamat",
                        ukuran: 15,
                        ketebalan: FontWeight.w400,
                        warna: Color(0xFFF5F5DC),
                      ),
                    ],
                  ),
                ],
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
            children: [
              Icon(
                Icons.calendar_month,
                color: Color(0xFFF5F5DC),
              ),
              Spasi(kesamping: 5),
              MyText(
                text: "$tanggal_daftar",
                ukuran: 15,
                ketebalan: FontWeight.w400,
                warna: Color(0xFFF5F5DC),
              ),
            ],
          ),
          Spasi(kebawah: 5),
          Row(
            children: [
              Icon(
                Icons.phone,
                color: Color(0xFFF5F5DC),
              ),
              Spasi(kesamping: 5),
              MyText(
                text: "$no_telephone",
                ukuran: 15,
                ketebalan: FontWeight.w400,
                warna: Color(0xFFF5F5DC),
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
                        builder: (context) => EditSupporter(
                          idSupporter: id_supporter,
                          namaSupporter: nama_supporter,
                          tanggalDaftar: tanggal_daftar,
                          alamat: alamat,
                          noTelephone: no_telephone,
                          foto: foto,
                        ),
                      ),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          _getDataSupporter();
                        });
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
                    _deleteClub(id_supporter, foto);
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

  _getDataSupporter() async {
    final response = await http.post(
      Uri.parse(ApiController.getApi()),
      body: {
        "aksi": "tampilSupporter",
      },
    );

    setState(() {
      _dataSupporter = jsonDecode(response.body);
    });
  }

  _deleteClub(id_supporter, String foto) async {
    await http.post(Uri.parse(ApiController().api), body: {
      "aksi": "hapusSupporter",
      "idSupporter": id_supporter,
      "namaFotoLama": foto,
    });
    _getDataSupporter();
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
        "aksi": "cariSupporter",
        "keywords": keywords,
      },
    );
    setState(() {
      _dataSupporter = jsonDecode(response.body);
    });
    // print(response.body);
  }

  TextField MyTextField(controller) {
    return TextField(
      onChanged: (String values) {
        if (values.isEmpty) {
          _getDataSupporter();
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
