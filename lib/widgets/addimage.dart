import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';

class AddImage extends StatefulWidget {
  final String text;
  final Function onTap;

  AddImage({required this.text, required this.onTap});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Container(
          height: sizeFromHeight(context, 15),
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Center(
              child: Text(
            '${widget.text}',
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
