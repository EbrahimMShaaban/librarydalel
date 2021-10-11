import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
Widget appBar(){
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
        SizedBox(
          width: 10,
        ),
        CircleAvatar(
          radius: 25,
          backgroundColor: white,
          backgroundImage: AssetImage('assets/logo.png'),
        ),
      ],
      centerTitle: true,
    ),
  );
}