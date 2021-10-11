import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/book_details/view.dart';

import 'eidt_button.dart';


class DisplaybookItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 70,
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: white,
          boxShadow: [BoxShadow(color: white, blurRadius: 6)],
          border: Border.all(color: purple, width: 1.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'اسم الكتاب',
              style: appbarStyle,
            ),
            Expanded(
              child: SizedBox(
                width: sizeFromWidth(context, 2),
              ),
            ),
            EditButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookDetails(
                            icon: Icons.edit,
                          )));
                },
                image: 'edit'),
            EditButton(
                onTap: () {
                  print('hhhh');
                },
                image: 'delete'),
          ],
        ),
      ),
    );
  }
}
