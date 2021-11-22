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
        elevation: 6,
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: purple, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        content: SizedBox(
            width: sizeFromWidth(context, 1),
            height: 30,
            // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Center(
              child: Text(
                text,
                style: textstyles,
              ),
            )),
        actions: <Widget>[
          ButtonUser(
            color: blueGradient,
            text: 'لا',
            onTap: () => Navigator.pop(context),
          ),
          ButtonUser(text: 'نعم', color: redGradient, onTap: () => ontap()),
        ],
      );
    },
  );
}
