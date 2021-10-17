import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';

class BooKCover extends StatelessWidget {
  final image;
  const BooKCover({Key? key,required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(context, 4),
      width: sizeFromWidth(context, 2.5),
      margin: const EdgeInsets.symmetric(horizontal: 15,),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(image) ,
            fit: BoxFit.contain
          )),

    );
    
  }
}
