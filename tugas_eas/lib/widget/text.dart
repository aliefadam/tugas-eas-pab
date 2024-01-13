import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text MyText(
    {String text = "", double? ukuran, FontWeight? ketebalan, Color? warna}) {
  return Text(
    text,
    style: GoogleFonts.poppins(
      fontSize: ukuran,
      fontWeight: ketebalan,
      color: warna,
    ),
  );
}
