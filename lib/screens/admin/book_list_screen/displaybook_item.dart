import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/add_book_screen/eidt_button.dart';

import 'package:librarydalel/screens/user/profile_screen/edit_profile/edit_profile_button.dart';



class DisplaybookItem extends StatelessWidget {
   final notes;
   final docsid;
   DisplaybookItem({
     required this.notes,
     required this.docsid,
});
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
             "${notes.data()['bookname']}",
              style: appbarStyle,
            ),
            Expanded(
              child: SizedBox(
                width: sizeFromWidth(context, 2),
              ),
            ),

            InkWell( onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => EditBook(notes:notes,docsid: docsid,)));
    },
                child: Icon(Icons.edit)),

          ],
        ),
      ),
    );
  }
}
