// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/user/home_screen/book_details/add_comment.dart';

import 'book_cover.dart';
import 'comments_item.dart';
import 'input_text.dart';

class BookDetails extends StatefulWidget {
  var bookname, authname, colnum, rownum, type, image, icon, id;

  BookDetails(
      {required this.bookname,
      required this.icon,
      required this.type,
      required this.image,
      required this.rownum,
      required this.colnum,
      required this.authname,
      required this.id});

  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
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
                            textDescribtion: widget.bookname.data()['bookname'],
                          ),
                          InputText(
                            stl: labelStyle2,                            text: 'اسم المؤلف',
                            textDescribtion: widget.authname.data()['authorname'],
                          ),
                          InputText(
                            stl: labelStyle2,                            text: 'رقم العمود ',
                            textDescribtion: widget.colnum.data()['columnnum'],
                          ),
                          InputText(
                            stl: labelStyle2,                            text: 'رقم الصف ',
                            textDescribtion: widget.rownum.data()['rownum'],
                          ),
                          InputText(
                            stl: labelStyle2,
                            text: 'نوع الكتاب ',
                            textDescribtion: widget.type.data()['type'],
                          ),
                        ],
                      ),
                    ),
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
                    child: FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('books')
                          .doc(widget.id)
                          .collection('comments')
                          .get(),
                      builder: (context, snapshot) {
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
              MaterialPageRoute(builder: (context) => AddComment(widget.id)));
        },
        child: Icon(widget.icon),
      ),
    );
  }
}
