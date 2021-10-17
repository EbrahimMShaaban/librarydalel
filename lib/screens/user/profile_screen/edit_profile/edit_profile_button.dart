// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';

class EditButton extends StatelessWidget {
  final String text;
  final Function onTap;

  const EditButton(this.text, {required this.onTap, });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onTap(),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20,
          ),
          height: sizeFromHeight(context, 13),
          width: sizeFromWidth(context, 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            color: white2,

          ),
          child: Text(
            text,
            style: buttonTextStyle
          ),

        ));
  }
}
