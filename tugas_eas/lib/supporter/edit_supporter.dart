import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugas_eas/controller/ApiController.dart';
import 'package:tugas_eas/widget/spasi.dart';
import 'package:tugas_eas/widget/text.dart';
import 'package:http/http.dart' as http;

class EditSupporter extends StatefulWidget {
  final String? idSupporter;
  final String? namaSupporter;
  final String? alamat;
  final String? tanggalDaftar;
  final String? noTelephone;
  final String? foto;

  const EditSupporter({
    Key? key,
    required this.idSupporter,
    required this.namaSupporter,
    required this.alamat,
    required this.tanggalDaftar,
    required this.noTelephone,
    required this.foto,
  }) : super(key: key);

  @override
  State<EditSupporter> createState() => _EditSupporterState();
}

class _EditSupporterState extends State<EditSupporter> {
  @override
  void initState() {
    super.initState();
    setState(() {
      _idSupporter.text = widget.idSupporter.toString();
      _namaSupporter.text = widget.namaSupporter.toString();
      _tanggalSudahDipilih = !_tanggalSudahDipilih;
      _tanggalDaftar.text = widget.tanggalDaftar.toString();
      _alamatSupporter.text = widget.alamat.toString();
      _noTelephone.text = widget.noTelephone.toString();
      _foto = widget.foto;
    });
  }

  var _idSupporter = TextEditingController();
  var _namaSupporter = TextEditingController();
  var _alamatSupporter = TextEditingController();
  var _noTelephone = TextEditingController();
  String? _foto;

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
          text: "EDIT SUPPORTER",
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
                text: "EDIT SUPPORTER",
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
              MyTextField(_idSupporter, false),
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
                          text: "Ganti Foto",
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
                // height: _selectedImage == null ? 400 : ,
                height: 400,
                decoration: BoxDecoration(
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: Color(0xFF004225),
                    ),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                clipBehavior: Clip.antiAlias,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: _selectedImage == null
                      ? Image.network("${ApiController.getUploadPath()}$_foto")
                      : Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Spasi(kebawah: 15),
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
                  if (_selectedImage == null) {
                    _editSupporter(
                      _idSupporter.text,
                      _namaSupporter.text,
                      _alamatSupporter.text,
                      _tanggalDaftar.text,
                      _noTelephone.text,
                    );
                  } else {
                    _editSupporterWithFoto(
                      _idSupporter.text,
                      _namaSupporter.text,
                      _alamatSupporter.text,
                      _tanggalDaftar.text,
                      _noTelephone.text,
                      _selectedImage!,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _editSupporter(
    String idSupporter,
    String namaSupporter,
    String alamat,
    String tanggalDaftar,
    String noTelephone,
  ) async {
    final request =
        http.MultipartRequest("POST", Uri.parse(ApiController.getApi()));
    request.fields["aksi"] = "editSupporter";
    request.fields["namaGambarLama"] = widget.foto.toString();
    request.fields["idSupporter"] = idSupporter;
    request.fields["namaSupporter"] = namaSupporter;
    request.fields["alamat"] = alamat;
    request.fields["tanggalDaftar"] = tanggalDaftar;
    request.fields["noTelephone"] = noTelephone;

    await request.send();
    Navigator.pop(context, _getDataSupporter());
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

  _editSupporterWithFoto(
    String idSupporter,
    String namaSupporter,
    String alamat,
    String tanggalDaftar,
    String noTelephone,
    File foto,
  ) async {
    final request =
        http.MultipartRequest("POST", Uri.parse(ApiController.getApi()));
    request.fields["aksi"] = "editSupporterWithFoto";
    request.fields["namaGambarLama"] = widget.foto.toString();
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
    Navigator.pop(context, _getDataSupporter());
    final snackbar = SnackBar(
      backgroundColor: Color(0xFFF5F5DC),
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

  _getDataSupporter() async {
    final response = await http.post(
      Uri.parse(ApiController.getApi()),
      body: {
        "aksi": "tampilSupporter",
      },
    );

    return jsonDecode(response.body);
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
        ));
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
