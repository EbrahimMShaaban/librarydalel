import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color purple = Color(0xFFb39ddb);
const Color clearGray = Color(0xffc4c4c4);
const Color gray = Color(0xFF8a8989);
const Color white = Color(0xFFfafafa);
const Color white2 = Color(0xfff1f1f1);
const Color black = Color(0xFF09090a);

const LinearGradient blueGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [.5, 1],
    colors: [white2, purple]);



const LinearGradient redGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [.5, .9],
    colors: [white2, Colors.red]);

TextStyle labelStyle = GoogleFonts.tajawal(
    textStyle: const  TextStyle(
        fontSize: 28, fontWeight: FontWeight.w600, color: gray, height: .2));
TextStyle labelStyle2 = GoogleFonts.tajawal(
    textStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: gray,
        height: 1.5));
TextStyle hintStyle = GoogleFonts.tajawal(
    textStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: clearGray,
        height: 1.5));
TextStyle buttonStyle = GoogleFonts.tajawal(
    textStyle: const TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: white, height: 1.5));
TextStyle appbarStyle = GoogleFonts.tajawal(
    textStyle:const TextStyle(
        fontSize: 24, fontWeight: FontWeight.w600, color: gray,));
TextStyle buttonTextStyle = GoogleFonts.tajawal(
    textStyle: const TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: purple, height: 1.5));
TextStyle textstyles = GoogleFonts.tajawal(
    textStyle:const TextStyle(
        fontSize: 15, fontWeight: FontWeight.bold, color: gray, height: 1.5));
TextStyle hintStyle2 = GoogleFonts.tajawal(
    textStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: clearGray,
        height: 1.5));
double sizeFromHeight(BuildContext context, double fraction,
    {bool hasAppBar = true}) {
  final screenHeight = MediaQuery.of(context).size.height;
  fraction = (hasAppBar ? (screenHeight - AppBar().preferredSize.
  height -
      MediaQuery.of(context).padding.top)
      : screenHeight) /
      fraction;
  return fraction;
}

double sizeFromWidth(BuildContext context, double fraction) {
  return MediaQuery.of(context).size.width / fraction;
}
