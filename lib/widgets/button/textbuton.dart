// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';


class Textbuton extends StatelessWidget{
   final String text;
   final Function onTap;
  const Textbuton(this.text,{required this.onTap} );
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {onTap();},
      child: Text(text),
    );
  }
}
