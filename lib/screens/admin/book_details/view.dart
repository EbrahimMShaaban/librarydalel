import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/book_details/comments_item.dart';
import 'package:librarydalel/screens/user/home_screen/add_comment.dart';

import 'book_cover.dart';
import 'input_text.dart';


class BookDetails extends StatefulWidget {
  final IconData icon;
  BookDetails({required this.icon});
  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [
            SizedBox(
              height: sizeFromHeight(context, 8),
            ),
            Center(
                child: Text(
                  'عرض تفاصيل الكتاب',
                  style: labelStyle,
                )),
            SizedBox(
              height: 35,
            ),
            Row(
              children: [
                Column(
                  children: [
                    InputText(
                      text: 'اسم الكتاب',
                      textDescribtion: '',
                    ),
                    InputText(
                      text: 'اسم المؤلف',
                      textDescribtion: '',
                    ),
                    InputText(
                      text: 'رقم العمود ',
                      textDescribtion: '',
                    ),
                    InputText(
                      text: 'رقم الصف ',
                      textDescribtion: '',
                    ),
                    InputText(
                      text: 'نوع الكتاب ',
                      textDescribtion: '',
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                BooKCover(),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: sizeFromHeight(context, 1.7),
              child: ListView.builder(itemBuilder: (context, index) {
                return CommentItem();
              }),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: purple,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddComment()));
        },
        child: Icon(widget.icon),
      ),
    );
  }
}
