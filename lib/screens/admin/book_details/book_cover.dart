import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';

class BooKCover extends StatelessWidget {
  const BooKCover({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(context, 4),
      width: sizeFromWidth(context, 3),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: purple,
          borderRadius: BorderRadius.circular(15),
          // image: DecorationImage(
          //   image: ,
          //   fit: BoxFit.contain
          // )),
      ),
      // child: Image(image: AssetImage('assets/book1.jpg')),
    );
    
  }
}
