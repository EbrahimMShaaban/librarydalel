import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color purple = Color(0xFFb39ddb);
const Color clear_gray = Color(0xffc4c4c4);
const Color gray = Color(0xFF8a8989);
const Color white = Color(0xFFfafafa);
const Color white2 = Color(0xfff1f1f1);
const Color black = Color(0xFF09090a);

TextStyle labelStyle = GoogleFonts.tajawal(
    textStyle: TextStyle(
        fontSize: 28, fontWeight: FontWeight.w600, color: gray, height: .2));
TextStyle hintStyle = GoogleFonts.tajawal(
    textStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: clear_gray,
        height: 1.5));
TextStyle buttonStyle = GoogleFonts.tajawal(
    textStyle: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: white, height: 1.5));
TextStyle appbarStyle = GoogleFonts.tajawal(
    textStyle: TextStyle(
        fontSize: 22, fontWeight: FontWeight.w600, color: gray, height: 1.5));
TextStyle buttonTextStyle = GoogleFonts.tajawal(
    textStyle: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: purple, height: 1.5));

double sizeFromHeight(BuildContext context, double fraction,
    {bool hasAppBar = true}) {
  final screenHeight = MediaQuery.of(context).size.height;
  fraction = (hasAppBar ? (screenHeight - AppBar().preferredSize.height -
      MediaQuery.of(context).padding.top)
      : screenHeight) /
      fraction;
  return fraction;
}

double sizeFromWidth(BuildContext context, double fraction) {
  return MediaQuery.of(context).size.width / fraction;
}
