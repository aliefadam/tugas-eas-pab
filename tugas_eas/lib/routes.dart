import 'package:flutter/material.dart';
import 'package:tugas_eas/home.dart';
import 'package:tugas_eas/klub/menu_klub.dart';
import 'package:tugas_eas/klub/tampil_club.dart';
import 'package:tugas_eas/login.dart';
import 'package:tugas_eas/supporter/menu_supporter.dart';
import 'package:tugas_eas/widget/spasi.dart';
import 'package:tugas_eas/widget/text.dart';

class Routes extends StatefulWidget {
  const Routes({super.key});

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) {
          return Home();
        },
        '/menu-klub': (context) {
          return MenuKlub();
        },
        '/tampil-klub': (context) {
          return TampilKlub();
        },
        '/menu-supporter': (context) {
          return MenuSupporter();
        }
      },
    );
  }
}

Widget drawerRoute(BuildContext context) {
  return Drawer(
    backgroundColor: Color(0xFF004225),
    child: Stack(
      children: [
        ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: MyText(
                text: "MENU",
                ketebalan: FontWeight.w900,
                warna: Color(0xFFF5F5DC),
                ukuran: 25,
              ),
            ),
            Divider(
              color: Color(0xFFF5F5DC),
              thickness: 2,
            ),
            _drawerItem(context, "/", "Home", Icons.home),
            Divider(
              color: Color(0xFFF5F5DC),
              thickness: 2,
            ),
            _drawerItem(context, "/menu-klub", "Klub", Icons.sports_soccer),
            Divider(
              color: Color(0xFFF5F5DC),
              thickness: 2,
            ),
            _drawerItem(context, "/menu-supporter", "Supporter", Icons.person),
            Divider(
              color: Color(0xFFF5F5DC),
              thickness: 2,
            ),
          ],
        ),
        Positioned(
          bottom: 15,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Login();
                    },
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                    color: Color(0xFFF5F5DC),
                  ),
                  Spasi(kesamping: 10),
                  MyText(
                    text: "LOGOUT",
                    ketebalan: FontWeight.w600,
                    warna: Color(0xFFF5F5DC),
                    ukuran: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

GestureDetector _drawerItem(
    BuildContext context, String routes, String title, IconData icon) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, routes);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Color(0xFFF5F5DC),
            size: 30,
          ),
          Spasi(kesamping: 10),
          MyText(
            text: title,
            warna: Color(0xFFF5F5DC),
            ketebalan: FontWeight.w600,
            ukuran: 20,
          ),
        ],
      ),
    ),
  );
}
