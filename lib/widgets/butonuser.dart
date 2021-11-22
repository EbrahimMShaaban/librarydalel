// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';

class ButtonUser extends StatefulWidget {
   ButtonUser({ required this.text,required this.color,required this.onTap});
  final String text;
   Gradient? color;
  final Function onTap;

  @override
  _ButtonUserState createState() => _ButtonUserState();
}

class _ButtonUserState extends State<ButtonUser> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap(),
      child: Container(
        alignment: Alignment.center,
        height: 35,
        margin:const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        width: sizeFromWidth(context, 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient:widget.color ,

        ),
        child: Align(
            alignment: Alignment.center,
            child: Text(widget.text, style: buttonStyle)),
      ),
    );
  }
}
