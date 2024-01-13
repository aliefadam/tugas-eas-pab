import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas_eas/controller/ApiController.dart';
import 'package:tugas_eas/login.dart';
import 'package:tugas_eas/widget/spasi.dart';
import 'package:tugas_eas/widget/text.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _nama = TextEditingController();
  var _username = TextEditingController();
  var _password = TextEditingController();
  var _konfPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF004225),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(40),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      text: "REGISTER",
                      ketebalan: FontWeight.w900,
                      warna: Color(0xFFF5F5DC),
                      ukuran: 50,
                    ),
                    Spasi(kebawah: 15),
                    MyTextField(_nama, "Nama"),
                    Spasi(kebawah: 15),
                    MyTextField(_username, "Username"),
                    Spasi(kebawah: 20),
                    MyTextField(_password, "Password", true),
                    Spasi(kebawah: 15),
                    MyTextField(_konfPassword, "Konfirmasi Password", true),
                    Spasi(kebawah: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF5F5DC),
                        fixedSize: Size(MediaQuery.sizeOf(context).width, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        _register();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.app_registration,
                            color: Color(0xFF004225),
                          ),
                          Spasi(kesamping: 10),
                          MyText(
                            text: "REGISTER",
                            ketebalan: FontWeight.w600,
                            warna: Color(0xFF004225),
                            ukuran: 20,
                          ),
                        ],
                      ),
                    ),
                    Spasi(kebawah: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(
                          text: "Sudah punya akun? ",
                          ketebalan: FontWeight.w400,
                          warna: Color(0xFFF5F5DC),
                          ukuran: 20,
                        ),
                        GestureDetector(
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
                          child: Text(
                            "Login",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: Color(0xFFF5F5DC),
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
      ),
    );
  }

  _register() async {
    if (_password.text != _konfPassword.text) {
      final snackbar = SnackBar(
        backgroundColor: Color(0xFFF5F5DC),
        content: MyText(
          text: "Konfirmasi Password Salah",
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
      return;
    }

    await http.post(
      Uri.parse(ApiController.getApi()),
      body: {
        "aksi": "register",
        "nama": _nama.text,
        "username": _username.text,
        "password": _password.text,
      },
    );
    final snackbar = SnackBar(
      backgroundColor: Color(0xFFF5F5DC),
      content: MyText(
        text: "Registrasi Berhasil!",
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Login();
        },
      ),
    );
  }

  TextField MyTextField(controller, label, [hidden = false]) {
    return TextField(
      obscureText: hidden,
      controller: controller,
      style: GoogleFonts.poppins(
        color: Color(0xFFF5F5DC),
        fontSize: 20,
      ),
      decoration: InputDecoration(
        label: MyText(
          text: label,
          ketebalan: FontWeight.w400,
          warna: Color(0xFFF5F5DC),
          ukuran: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 3,
            color: Color(0xFFF5F5DC),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 3,
            color: Color(0xFFF5F5DC),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
    );
  }
}
