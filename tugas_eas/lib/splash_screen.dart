import 'package:flutter/material.dart';
import 'package:tugas_eas/login.dart';
import 'package:tugas_eas/widget/text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Login();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF004225),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sports_soccer,
                  size: 200,
                  color: Color(0xFFF5F5DC),
                ),
                MyText(
                  text: "BOLA MANIA",
                  ketebalan: FontWeight.w900,
                  warna: Color(0xFFF5F5DC),
                  ukuran: 40,
                ),
              ],
            ),
          ),
          Positioned(
            width: MediaQuery.sizeOf(context).width,
            bottom: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(
                  text: "Bola Mania 1.0.0",
                  ketebalan: FontWeight.w400,
                  warna: Color(0xFFF5F5DC),
                  ukuran: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
