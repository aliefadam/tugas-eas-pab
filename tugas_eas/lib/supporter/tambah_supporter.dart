import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugas_eas/controller/ApiController.dart';
import 'package:tugas_eas/widget/spasi.dart';
import 'package:tugas_eas/widget/text.dart';
import 'package:http/http.dart' as http;

class TambahSupporter extends StatefulWidget {
  const TambahSupporter({super.key});

  @override
  State<TambahSupporter> createState() => _TambahSupporterState();
}

class _TambahSupporterState extends State<TambahSupporter> {
  var _idSupporter = TextEditingController();
  var _namaSupporter = TextEditingController();
  var _alamatSupporter = TextEditingController();
  var _noTelephone = TextEditingController();

  var daftarPeringkat = ["1-3", "4-6", "7-15", "16-18"];
  String _peringkatTerpilih = "1-3";

  var _tanggalDaftar = TextEditingController();
  DateTime _tanggalTerpilih = DateTime.now();
  bool _tanggalSudahDipilih = false;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      appBar: AppBar(
        backgroundColor: Color(0xFF004225),
        title: MyText(
          text: "TAMBAH SUPPORTER",
          ukuran: 20,
          ketebalan: FontWeight.w900,
          warna: Color(0xFFF5F5DC),
        ),
      ),
      // drawer: drawerRoute(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: ListView(
            children: <Widget>[
              MyText(
                text: "TAMBAH SUPPORTER",
                ukuran: 25,
                ketebalan: FontWeight.w800,
                warna: Color(0xFF004225),
              ),
              Spasi(kebawah: 25),
              MyText(
                text: "ID Supporter",
                warna: Color(0xFF004225),
                ukuran: 18,
                ketebalan: FontWeight.w600,
              ),
              Spasi(kebawah: 10),
              MyTextField(_idSupporter),
              Spasi(kebawah: 15),
              MyText(
                text: "Nama",
                warna: Color(0xFF004225),
                ukuran: 18,
                ketebalan: FontWeight.w600,
              ),
              Spasi(kebawah: 10),
              MyTextField(_namaSupporter),
              Spasi(kebawah: 15),
              MyText(
                text: "Alamat",
                warna: Color(0xFF004225),
                ukuran: 18,
                ketebalan: FontWeight.w600,
              ),
              Spasi(kebawah: 10),
              MyTextField(_alamatSupporter),
              Spasi(kebawah: 15),
              MyText(
                text: "Tanggal Daftar",
                warna: Color(0xFF004225),
                ukuran: 18,
                ketebalan: FontWeight.w600,
              ),
              Spasi(kebawah: 10),
              MyDatePicker(context),
              Spasi(kebawah: 15),
              MyText(
                text: "No Telephone",
                warna: Color(0xFF004225),
                ukuran: 18,
                ketebalan: FontWeight.w600,
              ),
              Spasi(kebawah: 10),
              MyTextField(_noTelephone),
              Spasi(kebawah: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    text: "Foto",
                    warna: Color(0xFF004225),
                    ukuran: 18,
                    ketebalan: FontWeight.w600,
                  ),
                  ElevatedButton(
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_a_photo,
                          color: Color(0xFFF5F5DC),
                          size: 15,
                        ),
                        Spasi(kesamping: 5),
                        MyText(
                          text: "Pilih Foto",
                          warna: Color(0xFFF5F5DC),
                          ukuran: 15,
                          ketebalan: FontWeight.w400,
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF004225),
                    ),
                    onPressed: () {
                      _pilihGambar();
                    },
                  ),
                ],
              ),
              Spasi(kebawah: 10),
              Container(
                width: 1000,
                decoration: BoxDecoration(
                  border: Border.fromBorderSide(
                    BorderSide(color: Color(0xFF004225)),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                clipBehavior: Clip.antiAlias,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: _selectedImage == null
                      ? Image.asset(
                          "assets/imgs/no_image.jpg",
                        )
                      : Image.file(_selectedImage!),
                ),
              ),
              Spasi(kebawah: 15),
              ElevatedButton(
                child: MyText(
                  text: "Tambah Supporter",
                  warna: Color(0xFFF5F5DC),
                  ukuran: 18,
                  ketebalan: FontWeight.w600,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF004225),
                  fixedSize: Size(1000, 50),
                ),
                onPressed: () {
                  // print(_idSupporter.text);
                  // print(_namaSupporter.text);
                  // print(_tanggalDaftar.text);
                  // print(_noTelephone.text);
                  // print(_selectedImage);

                  _tambahSupporter(
                    _idSupporter.text,
                    _namaSupporter.text,
                    _alamatSupporter.text,
                    _tanggalDaftar.text,
                    _noTelephone.text,
                    _selectedImage!,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _tambahSupporter(
    String idSupporter,
    String namaSupporter,
    String alamat,
    String tanggalDaftar,
    String noTelephone,
    File foto,
  ) async {
    final String url = ApiController.getApi();
    final request = http.MultipartRequest("POST", Uri.parse(url));
    request.fields["aksi"] = "tambahSupporter";
    request.fields["idSupporter"] = idSupporter;
    request.fields["namaSupporter"] = namaSupporter;
    request.fields["alamat"] = alamat;
    request.fields["tanggalDaftar"] = tanggalDaftar;
    request.fields["noTelephone"] = noTelephone;

    request.files.add(http.MultipartFile(
      "foto",
      foto.readAsBytes().asStream(),
      foto.lengthSync(),
      filename: foto.path.split("/").last,
    ));
    await request.send();
    Navigator.pop(context);
    final snackbar = SnackBar(
      backgroundColor: Color(0xFF004225),
      content: MyText(
        text: "Berhasil Menambah Data",
        warna: Color(0xFFF5F5DC),
        ketebalan: FontWeight.w600,
        ukuran: 15,
      ),
      action: SnackBarAction(
        textColor: Color(0xFFF5F5DC),
        label: 'Tutup',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  TextField MyTextField(controller) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(
        color: Color(0xFF004225),
      ),
      decoration: InputDecoration(
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

  _pilihTanggal(BuildContext context) async {
    DateTime? tanggal = await showDatePicker(
      context: context,
      initialDate: _tanggalTerpilih,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xFF004225),
            colorScheme: ColorScheme.light(primary: Color(0xFF004225)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: child!,
          ),
        );
      },
    );

    if (tanggal != null && tanggal != _tanggalTerpilih) {
      setState(() {
        _tanggalTerpilih = tanggal;
        _tanggalDaftar.text = "${tanggal.toLocal()}".split(' ')[0];
        _tanggalSudahDipilih = true;
      });
    }
  }

  Future<void> _pilihGambar() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      setState(() {
        _selectedImage = File(selectedImage.path);
      });
    }
  }

  GestureDetector MyDatePicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pilihTanggal(context);
      },
      child: Container(
        width: 1000,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(
              color: Color(0xFF004225),
            ),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              text: !_tanggalSudahDipilih
                  ? "Pilih Tanggal Daftar"
                  : _tanggalDaftar.text,
              warna: Color(0xFF004225),
              ketebalan: FontWeight.w500,
              ukuran: 15,
            ),
            Icon(
              Icons.calendar_month,
              color: Color(0xFF004225),
            ),
          ],
        ),
      ),
    );
  }

  Container MyDropDown() {
    return Container(
      width: 1000,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(
            color: Color(0xFF004225),
          ),
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButton(
        value: _peringkatTerpilih,
        items: daftarPeringkat.map((jurusan) {
          return DropdownMenuItem(
            child: MyText(
              text: jurusan,
              warna: Color(0xFF004225),
              ketebalan: FontWeight.w500,
              ukuran: 15,
            ),
            value: jurusan,
          );
        }).toList(),
        onChanged: (values) {
          setState(() {
            _peringkatTerpilih = values.toString();
          });
        },
        borderRadius: BorderRadius.circular(20),
        isExpanded: true,
        underline: Container(),
        icon: Icon(
          Icons.arrow_drop_down_circle,
          color: Color(0xFF004225),
        ),
      ),
    );
  }
}
