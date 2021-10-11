import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';

class AddImage extends StatelessWidget {
  final String text;

  AddImage(this.text);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Container(
          height: sizeFromHeight(context, 15),
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Center(
              child: Text(
            '$text',
            style: hintStyle,
          )),
          decoration: BoxDecoration(
              color: white,
              border: Border.all(
                color: purple,
                width: 2,
              )),
        ),
      ),
    );
  }
}
