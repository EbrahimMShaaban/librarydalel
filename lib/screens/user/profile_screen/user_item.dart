// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
// ignore_for_file: use_key_in_widget_constructors


class UserItem extends StatefulWidget {
  const UserItem(this.textaddress, {required this.textContainer});

  final  textaddress;
  final textContainer;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.textaddress,
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
            widget.textContainer,
            style: appbarStyle,
          ),
        ),
      ],
    );
  }
}
