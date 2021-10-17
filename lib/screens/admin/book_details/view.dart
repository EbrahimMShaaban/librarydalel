// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/book_details/comments_item.dart';
import 'package:librarydalel/screens/user/home_screen/add_comment.dart';

import 'book_cover.dart';
import 'input_text.dart';

class BookDetails extends StatefulWidget {
  final IconData icon;
  final bookname, authname, colnum, rownum, type, image;

  const BookDetails(
      {Key? key,
      required this.icon,
      required this.rownum,
      required this.bookname,
      required this.type,
      required this.authname,
      required this.colnum,
      required this.image})
      : super(key: key);

  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        title:  Text(
          'عرض تفاصيل الكتاب',
          style: appbarStyle,
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),color: purple,),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [

            const SizedBox(
              height:20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputText(
                      text: 'اسم الكتاب',
                      textDescribtion: widget.bookname.data()['bookname'],
                    ),
                    InputText(
                      text: 'اسم المؤلف',
                      textDescribtion: widget.authname.data()['authorname'],
                    ),
                    InputText(
                      text: 'رقم العمود ',
                      textDescribtion: widget.colnum.data()['columnnum'],
                    ),
                    InputText(
                      text: 'رقم الصف ',
                      textDescribtion: widget.rownum.data()['rownum'],
                    ),
                    InputText(
                      text: 'نوع الكتاب ',
                      textDescribtion: widget.type.data()['type'],
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                BooKCover(
                  image: widget.image.data()['imageurl'],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: sizeFromHeight(context, 1.7),
              child: ListView.builder(itemBuilder: (context, index) {
                return const CommentItem();
              }),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: purple,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddComment()));
        },
        child: Icon(widget.icon),
      ),
    );
  }
}
