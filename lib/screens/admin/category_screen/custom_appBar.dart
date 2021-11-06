// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
Widget myAppBar(){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
    child: AppBar(
      backgroundColor: white,
      elevation: 0,
      actions: [
        Center(
          child: Text(
            'دليل المكتبة',
            style: appbarStyle,
            textDirection: TextDirection.rtl,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const CircleAvatar(
          radius: 25,
          backgroundColor: white,
          backgroundImage: AssetImage('assets/logo3.png'),
        ),
      ],
      centerTitle: true,
    ),
  );
}