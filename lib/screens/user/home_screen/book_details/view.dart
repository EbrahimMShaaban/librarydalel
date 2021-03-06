// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/user/home_screen/book_details/add_comment.dart';

import 'book_cover.dart';
import 'comments_item.dart';
import 'input_text.dart';

class BookUserDetails extends StatefulWidget {
  final bookname, authname, colnum, rownum, type, image, icon, id;

  BookUserDetails(
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

class _BookDetailsState extends State<BookUserDetails> {
  var name = FirebaseAuth.instance.currentUser!.email;

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
                        InputText(stl: labelStyle2,
                          text: 'اسم الكتاب',
                          textDescribtion: widget.bookname.data()['bookname'],
                        ),
                        InputText(stl: labelStyle2,
                          text: 'اسم المؤلف',
                          textDescribtion: widget.authname.data()['authorname'],
                        ),
                        InputText(stl: labelStyle2,
                          text: 'رقم العمود ',
                          textDescribtion: widget.colnum.data()['columnnum'],
                        ),
                        InputText(stl: labelStyle2,
                          text: 'رقم الصف ',
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
              Text(
                'نبذة عن الكتاب:'+widget.type.data()['aboutBook'],
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
              Expanded(

                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('books')
                        .doc(widget.id)
                        .collection('comments')
                        .snapshots(),
                    builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {

                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return CommentItem(
                                id: widget.id,
                                length: snapshot.data!.docs.length,
                                comment: snapshot.data!.docs[index]['comment'],
                                date: snapshot.data!.docs[index]['date']
                                    .toString(),
                                name: snapshot.data!.docs[index]['name'],
                              );
                            });
                      }
                      return const Text('');
                    },

                  )),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: purple,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddComment(
                        widget.id,
                      )));
        },
        child: Icon(widget.icon),
      ),
    );
  }
}
