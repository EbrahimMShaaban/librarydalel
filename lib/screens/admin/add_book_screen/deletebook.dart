import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/widgets/butonuser.dart';

showDialogWarning(
    BuildContext context, {
      required String text,
      required Function ontap,
    }) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 10,
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: purple, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        content: Container(
            width: sizeFromWidth(context, 1),
            height: 40,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              text,
              style: labelStyle2,
            )),
        actions: <Widget>[
          ButtonUser(
            text: 'لا',
            color: redGradient,
            onTap: () => Navigator.pop(context),
          ),
          ButtonUser(text: 'نعم', color: blueGradient, onTap: () => ontap()),
        ],
      );
    },
  );
}