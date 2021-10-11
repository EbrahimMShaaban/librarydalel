import 'package:flutter/material.dart';


class Textbuton extends StatelessWidget{
   final String text;
   final Function onTap;
  Textbuton(this.text,{required this.onTap} );
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {onTap();},
      child: Text(text),
    );
  }
}
