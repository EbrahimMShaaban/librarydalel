import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
// ignore_for_file: use_key_in_widget_constructors

class CategoryItem extends StatelessWidget {
 final String text;
 final Function onTap;
const CategoryItem({   required this.text,
  required this.onTap,}
    );
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ()=>onTap(),
      child: Container(
        width: sizeFromWidth(context, 1.5),
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: white,
            boxShadow: const[BoxShadow(
              color: purple,
              blurRadius: 3.5,
            )]
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Center(child: Text(text,style: labelStyle,)),
        ),
      ),
    );
  }
}
