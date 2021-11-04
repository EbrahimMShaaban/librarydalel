// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';

class BooKCover extends StatelessWidget {
  final image;
  const BooKCover({Key? key,required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(context, 5),
      width: sizeFromWidth(context, 3),
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                image),
            fit: BoxFit.cover,
          ),
          color: gray,
          borderRadius: BorderRadius.circular(23)),
    );
    
  }
}
