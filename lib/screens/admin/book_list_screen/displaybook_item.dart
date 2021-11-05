// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/add_book_screen/eidt_book.dart';
import 'package:librarydalel/screens/admin/book_details/view.dart';

class DisplaybookItem extends StatelessWidget {
  final bookName;
  final docsid;
  final authname, colnum, rownum, type, image, icon;

  const DisplaybookItem({
    Key? key,
    required this.bookName,
    required this.docsid,
    required this.icon,
    required this.type,
    required this.image,
    required this.rownum,
    required this.colnum,
    required this.authname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookDetails(
                      bookname: bookName,
                      icon: icon,
                      type: type,
                      image: image,
                      rownum: rownum,
                      colnum: colnum,
                      authname: authname,
                      id: docsid)));
        },
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: white,
            boxShadow: const [BoxShadow(color: white, blurRadius: 6)],
            border: Border.all(color: purple, width: 1.5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Text(
                  "${bookName.data()['bookname']}",maxLines: 2,
                  style: GoogleFonts.tajawal(
                      textStyle:const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w600, color: gray,)),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: sizeFromWidth(context, 2),
                ),
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditBook(
                                  books: bookName,
                                  docsid: docsid,
                                )));
                  },
                  child: const Icon(Icons.edit)),
              SizedBox(
                width: sizeFromWidth(context, 25),
              ),

              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditBook(
                              books: bookName,
                              docsid: docsid,
                            )));
                  },
                  child: const Icon(Icons.delete))
            ],
          ),
        ),
      ),
    );
  }
}
