import 'package:flutter/material.dart';
import 'package:tugas_eas/klub/tambah_klub.dart';
import 'package:tugas_eas/klub/tampil_club.dart';
import 'package:tugas_eas/routes.dart';
import 'package:tugas_eas/widget/spasi.dart';
import 'package:tugas_eas/widget/text.dart';

class MenuKlub extends StatefulWidget {
  const MenuKlub({super.key});

  @override
  State<MenuKlub> createState() => _MenuKlubState();
}

class _MenuKlubState extends State<MenuKlub> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      appBar: AppBar(
        backgroundColor: Color(0xFF004225),
        title: MyText(
          text: "MENU KLUB",
          ukuran: 20,
          ketebalan: FontWeight.w900,
          warna: Color(0xFFF5F5DC),
        ),
      ),
      drawer: drawerRoute(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: ListView(
            children: <Widget>[
              _menuItem(
                  context, "Tambah Klub", TambahKlub(), Icons.add_box_rounded),
              Spasi(kebawah: 25),
              _menuItem(context, "Laporan Data Klub", TampilKlub(),
                  Icons.receipt_long_outlined),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _menuItem(BuildContext context, String text, routes, icon) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return routes;
          }),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: Color(0xFF004225),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: Offset(0, 2),
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: Color(0xFFF5F5DC),
                ),
                Spasi(kesamping: 5),
                MyText(
                  text: text,
                  ketebalan: FontWeight.w600,
                  warna: Color(0xFFF5F5DC),
                  ukuran: 20,
                ),
              ],
            ),
            Icon(
              Icons.arrow_right,
              size: 40,
              color: Color(0xFFF5F5DC),
            ),
          ],
        ),
      ),
    );
  }
}
