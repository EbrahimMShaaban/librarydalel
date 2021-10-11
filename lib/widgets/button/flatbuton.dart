import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
class Buton extends StatelessWidget {
 final String text;
 final Function onTap;
  Buton(this.text,{required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () =>onTap(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15,
          ),
          height: sizeFromHeight(context, 13),
          width: sizeFromWidth(context, 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: purple,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            style: buttonStyle,
          ),
        ));
  }
}
