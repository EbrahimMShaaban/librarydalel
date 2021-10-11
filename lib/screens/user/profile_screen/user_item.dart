import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';

class UserItem extends StatelessWidget {
  UserItem(this.textaddress, {required this.textContainer});

  final String textaddress;
  final String textContainer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            textaddress,
            style: appbarStyle,
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerRight,
          height: 55,
          width: sizeFromWidth(context, 1),
          margin: EdgeInsets.symmetric(horizontal: 15),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
