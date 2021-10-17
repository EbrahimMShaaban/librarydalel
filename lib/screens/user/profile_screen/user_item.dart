import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
// ignore_for_file: use_key_in_widget_constructors


class UserItem extends StatelessWidget {
  const UserItem(this.textaddress, {required this.textContainer});

  final String textaddress;
  final String textContainer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            textaddress,
            style: appbarStyle,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerRight,
          height: 55,
          width: sizeFromWidth(context, 1),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: white2,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            textContainer,
            style: appbarStyle,
          ),
        ),
      ],
    );
  }
}
