import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
class CategoryItem extends StatelessWidget {
 final String text;
 final Function onTap;
CategoryItem({   required this.text,
  required this.onTap,}
    );
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ()=>onTap(),
      child: Container(
        width: sizeFromWidth(context, 1.5),
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: white,
            boxShadow: [BoxShadow(
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
