import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tugas_eas/controller/ApiController.dart';
import 'package:tugas_eas/routes.dart';
import 'package:tugas_eas/widget/spasi.dart';
import 'package:tugas_eas/widget/text.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _totalClub = "";
  String _totalSupporter = "";

  @override
  void initState() {
    super.initState();
    _getTotalClub();
    _getTotalSupporter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      appBar: AppBar(
        backgroundColor: Color(0xFF004225),
        title: MyText(
          text: "HOME",
          ukuran: 20,
          ketebalan: FontWeight.w900,
          warna: Color(0xFFF5F5DC),
        ),
      ),
      drawer: drawerRoute(context),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            MyText(
              text: "BOLA MANIA",
              ketebalan: FontWeight.w900,
              warna: Color(0xFF004225),
              ukuran: 40,
            ),
            Spasi(kebawah: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFF004225),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 2),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          MyText(
                            text: _totalClub,
                            ketebalan: FontWeight.w600,
                            warna: Color(0xFFF5F5DC),
                            ukuran: 50,
                          ),
                          MyText(
                            text: "Klub Terdaftar",
                            ketebalan: FontWeight.w600,
                            warna: Color(0xFFF5F5DC),
                            ukuran: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spasi(kesamping: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFF004225),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 2),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          MyText(
                            text: _totalSupporter,
                            ketebalan: FontWeight.w600,
                            warna: Color(0xFFF5F5DC),
                            ukuran: 50,
                          ),
                          MyText(
                            text: "Supporter Terdaftar",
                            ketebalan: FontWeight.w600,
                            warna: Color(0xFFF5F5DC),
                            ukuran: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _getTotalClub() async {
    final response = await http.post(Uri.parse(ApiController.getApi()), body: {
      "aksi": "getTotalKlub",
    });

    setState(() {
      _totalClub = jsonDecode(response.body);
    });
  }

  _getTotalSupporter() async {
    final response = await http.post(Uri.parse(ApiController.getApi()), body: {
      "aksi": "getTotalSupporter",
    });

    setState(() {
      _totalSupporter = jsonDecode(response.body);
    });
  }
}
