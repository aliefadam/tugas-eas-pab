import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas_eas/controller/ApiController.dart';
import 'package:tugas_eas/widget/spasi.dart';
import 'package:tugas_eas/widget/text.dart';
import 'package:http/http.dart' as http;

class EditClub extends StatefulWidget {
  final String? idKlub;
  final String? namaKlub;
  final String? tanggalBerdiri;
  final String? kondisiKlub;
  final String? kotaKlub;
  final String? peringkat;
  final String? hargaKlub;

  const EditClub({
    Key? key,
    required this.idKlub,
    required this.namaKlub,
    required this.tanggalBerdiri,
    required this.kondisiKlub,
    required this.kotaKlub,
    required this.peringkat,
    required this.hargaKlub,
  }) : super(key: key);

  @override
  State<EditClub> createState() => _EditClubState();
}

class _EditClubState extends State<EditClub> {
  @override
  void initState() {
    super.initState();
    setState(() {
      _idKlub.text = widget.idKlub.toString();
      _namaKlub.text = widget.namaKlub.toString();
      _tanggalSudahDipilih = !_tanggalSudahDipilih;
      _tanggalBerdiri.text = widget.tanggalBerdiri.toString();
      _kondisiKlub = widget.kondisiKlub.toString();
      _kotaKlub.text = widget.kotaKlub.toString();
      _peringkatTerpilih = widget.peringkat.toString();
      _hargaKlub.text = widget.hargaKlub.toString();
    });
  }

  var _idKlub = TextEditingController();
  var _namaKlub = TextEditingController();
  var _kotaKlub = TextEditingController();
  var _hargaKlub = TextEditingController();

  var daftarPeringkat = ["1-3", "4-6", "7-15", "16-18"];
  String _peringkatTerpilih = "4-6";

  var _hobbyDipilih = [];
  var _tanggalBerdiri = TextEditingController();
  var _kondisiKlub = "";
  DateTime _tanggalTerpilih = DateTime.now();
  bool _tanggalSudahDipilih = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      appBar: AppBar(
        backgroundColor: Color(0xFF004225),
        title: MyText(
          text: "EDIT KLUB",
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
                text: "EDIT KLUB",
                ukuran: 25,
                ketebalan: FontWeight.w800,
                warna: Color(0xFF004225),
              ),
              Spasi(kebawah: 25),
              MyText(
                text: "ID Klub",
                warna: Color(0xFF004225),
                ukuran: 18,
                ketebalan: FontWeight.w600,
              ),
              Spasi(kebawah: 10),
              MyTextField(_idKlub, false),
              Spasi(kebawah: 15),
              MyText(
                text: "Nama Klub",
                warna: Color(0xFF004225),
                ukuran: 18,
                ketebalan: FontWeight.w600,
              ),
              Spasi(kebawah: 10),
              MyTextField(_namaKlub),
              Spasi(kebawah: 15),
              MyText(
                text: "Tanggal Berdiri",
                warna: Color(0xFF004225),
                ukuran: 18,
                ketebalan: FontWeight.w600,
              ),
              Spasi(kebawah: 10),
              MyDatePicker(context),
              Spasi(kebawah: 15),
              MyText(
                text: "Kondisi Klub",
                warna: Color(0xFF004225),
                ukuran: 18,
                ketebalan: FontWeight.w600,
              ),
              Spasi(kebawah: 10),
              MyRadio(),
              Spasi(kebawah: 15),
              MyText(
                text: "Kota Klub",
                warna: Color(0xFF004225),
                ukuran: 18,
                ketebalan: FontWeight.w600,
              ),
              Spasi(kebawah: 10),
              MyTextField(_kotaKlub),
              Spasi(kebawah: 15),
              MyText(
                text: "Peringkat",
                warna: Color(0xFF004225),
                ukuran: 18,
                ketebalan: FontWeight.w600,
              ),
              Spasi(kebawah: 10),
              MyDropDown(),
              Spasi(kebawah: 15),
              MyText(
                text: "Harga Klub",
                warna: Color(0xFF004225),
                ukuran: 18,
                ketebalan: FontWeight.w600,
              ),
              Spasi(kebawah: 10),
              MyTextField(_hargaKlub),
              Spasi(kebawah: 20),
              ElevatedButton(
                child: MyText(
                  text: "Simpan Perubahan",
                  warna: Color(0xFFF5F5DC),
                  ukuran: 18,
                  ketebalan: FontWeight.w600,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF004225),
                  fixedSize: Size(1000, 50),
                ),
                onPressed: () {
                  _updateKlub(
                    _idKlub.text,
                    _namaKlub.text,
                    _tanggalBerdiri.text,
                    _kondisiKlub,
                    _kotaKlub.text,
                    _peringkatTerpilih,
                    _hargaKlub.text,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _updateKlub(
    String idKlub,
    String namaKlub,
    String tanggalBerdiri,
    String kondisiKlub,
    String kotaKlub,
    String peringkat,
    String hargaKlub,
  ) async {
    final String url = ApiController().api;

    final request = http.MultipartRequest("POST", Uri.parse(url));
    request.fields["aksi"] = "editKlubBola";
    request.fields["idKlub"] = idKlub;
    request.fields["namaKlub"] = namaKlub;
    request.fields["tanggalBerdiri"] = tanggalBerdiri;
    request.fields["kondisiKlub"] = kondisiKlub;
    request.fields["kotaKlub"] = kotaKlub;
    request.fields["peringkat"] = peringkat;
    request.fields["hargaKlub"] = hargaKlub;
    await request.send();

    Navigator.pop(context, "true");
    final snackbar = SnackBar(
      backgroundColor: Colors.white,
      content: MyText(
        text: "Berhasil Mengedit Data",
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

  TextField MyTextField(controller, [readOnly = true]) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(
        color: Color(0xFF004225),
      ),
      decoration: InputDecoration(
        enabled: readOnly,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF004225),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        disabledBorder: readOnly
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF004225),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              )
            : OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF004225),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
        enabledBorder: readOnly
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF004225),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              )
            : OutlineInputBorder(
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

  Container MyCheckbox() {
    return Container(
      width: 1000,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(
            color: Color(0xFF004225),
          ),
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: _hobbyDipilih.contains("Memancing"),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      _hobbyDipilih.add("Memancing");
                    } else {
                      _hobbyDipilih.remove("Memancing");
                    }
                  });
                },
                side: BorderSide(color: Color(0xFF004225), width: 2),
                checkColor: Color(0xFFF5F5DC),
                activeColor: Color(0xFF004225),
              ),
              MyText(
                text: "Memancing",
                warna: Color(0xFF004225),
                ukuran: 15,
              ),
              Spasi(kesamping: 10),
              Checkbox(
                value: _hobbyDipilih.contains("Bermain Game"),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      _hobbyDipilih.add("Bermain Game");
                    } else {
                      _hobbyDipilih.remove("Bermain Game");
                    }
                  });
                },
                side: BorderSide(color: Color(0xFF004225), width: 2),
                checkColor: Color(0xFFF5F5DC),
                activeColor: Color(0xFF004225),
              ),
              MyText(
                text: "Bermain Game",
                warna: Color(0xFF004225),
                ukuran: 15,
              ),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: _hobbyDipilih.contains("Bersepeda"),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      _hobbyDipilih.add("Bersepeda");
                    } else {
                      _hobbyDipilih.remove("Bersepeda");
                    }
                  });
                },
                side: BorderSide(color: Color(0xFF004225), width: 2),
                checkColor: Color(0xFFF5F5DC),
                activeColor: Color(0xFF004225),
              ),
              MyText(
                text: "Bersepeda",
                warna: Color(0xFF004225),
                ukuran: 15,
              ),
              Spasi(kesamping: 10),
              Checkbox(
                value: _hobbyDipilih.contains("Mendaki Gunung"),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      _hobbyDipilih.add("Mendaki Gunung");
                    } else {
                      _hobbyDipilih.remove("Mendaki Gunung");
                    }
                  });
                },
                side: BorderSide(color: Color(0xFF004225), width: 2),
                checkColor: Color(0xFFF5F5DC),
                activeColor: Color(0xFF004225),
              ),
              MyText(
                text: "Mendaki Gunung",
                warna: Color(0xFF004225),
                ukuran: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container MyRadio() {
    return Container(
      width: 1000,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      decoration: BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(
            color: Color(0xFF004225),
          ),
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Radio(
            activeColor: Color(0xFF004225),
            fillColor: MaterialStateProperty.all(Color(0xFF004225)),
            value: "Baik",
            groupValue: _kondisiKlub,
            onChanged: (value) {
              setState(() {
                _kondisiKlub = value.toString();
              });
            },
          ),
          MyText(
            text: "Baik",
            ukuran: 15,
            warna: Color(0xFF004225),
          ),
          Spasi(kesamping: 10),
          Radio(
            activeColor: Color(0xFF004225),
            fillColor: MaterialStateProperty.all(Color(0xFF004225)),
            value: "Tidak Baik",
            groupValue: _kondisiKlub,
            onChanged: (value) {
              setState(() {
                _kondisiKlub = value.toString();
              });
            },
          ),
          MyText(
            text: "Tidak Baik",
            ukuran: 15,
            warna: Color(0xFF004225),
          ),
          Radio(
            activeColor: Color(0xFF004225),
            fillColor: MaterialStateProperty.all(Color(0xFF004225)),
            value: "Bangkrut",
            groupValue: _kondisiKlub,
            onChanged: (value) {
              setState(() {
                _kondisiKlub = value.toString();
              });
            },
          ),
          MyText(
            text: "Bangkrut",
            ukuran: 15,
            warna: Color(0xFF004225),
          ),
        ],
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
        _tanggalBerdiri.text = "${tanggal.toLocal()}".split(' ')[0];
        _tanggalSudahDipilih = true;
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
                  ? "Pilih Tanggal Lahir"
                  : _tanggalBerdiri.text,
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
