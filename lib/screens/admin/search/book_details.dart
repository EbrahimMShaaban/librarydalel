// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors, avoid_print, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/book_details/book_cover.dart';
import 'package:librarydalel/screens/admin/book_details/comments_item.dart';
import 'package:librarydalel/screens/admin/book_details/input_text.dart';
import 'package:librarydalel/screens/user/home_screen/book_details/add_comment.dart';
class BookDetailsSearch extends StatefulWidget {
  String? bookname, authname, colnum, rownum, type, image,  id, aboutBook;
  IconData ?icon;

  BookDetailsSearch(
      {required this.bookname,
        required this.icon,
        required this.type,
        required this.image,
        required this.rownum,
        required this.colnum,
        required this.authname,
        required this.aboutBook,
        required this.id});

  @override
  _BookDetailsSearchState createState() => _BookDetailsSearchState();
}

class _BookDetailsSearchState extends State<BookDetailsSearch> {
  @override
  void initState() {
    print(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        title: Text(
          'عرض تفاصيل الكتاب',
          style: appbarStyle,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: purple,
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputText(
                            stl: labelStyle2,

                            text: 'اسم الكتاب',
                            textDescribtion: widget.bookname,
                          ),
                          InputText(
                            stl: labelStyle2,
                            text: 'اسم المؤلف',
                            textDescribtion:
                            widget.authname,
                          ),
                          InputText(
                            stl: labelStyle2,
                            text: 'رقم العمود ',
                            textDescribtion: widget.colnum,
                          ),
                          InputText(
                            stl: labelStyle2,
                            text: 'رقم الصف ',
                            textDescribtion: widget.rownum,
                          ),
                          InputText(
                            stl: labelStyle2,
                            text: 'نوع الكتاب ',
                            textDescribtion: widget.type,
                          ),
                          // InputText(
                          //   stl: labelStyle2,
                          //   text: 'نبذة عن الكتاب',
                          //   textDescribtion: widget.type.data()['aboutBook'],
                          // ),

                        ],
                      ),
                    ),
                    BooKCover(
                      image: widget.image,
                    ),
                  ],
                ),

                Text(
                  'نبذة عن الكتاب:'+ widget.aboutBook!,
                  style: GoogleFonts.tajawal(
                      textStyle: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: gray,
                          height: 1.5)),
                  overflow: TextOverflow.clip,
                  maxLines: 3,
                ),

                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: sizeFromHeight(context, 1.7),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('books')
                          .doc(widget.id)
                          .collection('comments')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text('');
                        }
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  onDismissed: (diretion) async {
                                    await FirebaseFirestore.instance
                                        .collection('books')
                                        .doc(widget.id)
                                        .collection('comments')
                                        .doc(snapshot.data!.docs[index].id)
                                        .delete();
                                  },
                                  key: UniqueKey(),
                                  child: CommentItem(
                                    comment: snapshot.data!.docs[index]
                                    ['comment'],
                                    date: snapshot.data!.docs[index]['date']
                                        .toString(),
                                    name: snapshot.data!.docs[index]['name'],
                                  ),
                                );
                              });
                        }
                        return const CircularProgressIndicator();
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: purple,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddComment(widget.id!)));
        },
        child: Icon(widget.icon),
      ),
    );
  }
}
//todo: