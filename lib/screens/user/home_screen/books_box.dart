import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/book_details/view.dart';


class BooksBox extends StatelessWidget {
// الكلاس ده عبارة عن البوكس اللي هيكون فيه الكتاب مع اسمه من تحت ..وهنستدعيها في ال rowbooks
  final int length;

  BooksBox(this.length);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          //color: Colors.red,
          height: sizeFromHeight(context, 4),
          width: sizeFromWidth(context, 1),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                borderRadius: BorderRadius.circular(23),
                highlightColor: purple,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookDetails(
                                icon: Icons.add,
                              )));
                },
                child: Column(
                  children: [
                    Container(
                      height: sizeFromHeight(context, 6),
                      width: sizeFromWidth(context, 4.6),
                      margin: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/book.png'),
                            fit: BoxFit.cover,
                          ),
                          color: gray,
                          borderRadius: BorderRadius.circular(23)),
                    ),
                    Text(
                      'اسم الكتاب',
                      style: GoogleFonts.tajawal(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: gray,
                              height: 1.5)),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
