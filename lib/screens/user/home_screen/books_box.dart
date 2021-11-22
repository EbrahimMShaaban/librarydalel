// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/user/home_screen/book_details/view.dart';

class BooksBox extends StatefulWidget {
  final type;

  const BooksBox({required this.type, Key? key}) : super(key: key);

  @override
  State<BooksBox> createState() => _BooksBoxState();
}

class _BooksBoxState extends State<BooksBox> {

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('books')
                .where('type', isEqualTo: widget.type)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {

                  return SizedBox(
                    height: sizeFromHeight(context, 4),
                    width: sizeFromWidth(context, 1),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return  InkWell(

                          borderRadius: BorderRadius.circular(23),
                          highlightColor: purple,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookUserDetails(
                                      icon: Icons.add,
                                      id:snapshot.data!.docs[index].id,
                                      bookname: snapshot.data!.docs[index],
                                      authname: snapshot.data!.docs[index],
                                      colnum: snapshot.data!.docs[index],
                                      type: snapshot.data!.docs[index],
                                      image: snapshot.data!.docs[index],
                                      rownum: snapshot.data!.docs[index],
                                    )));
                          },
                          child: SizedBox(
                            width: sizeFromWidth(context, 4),
                            child: Column(
                              children: [
                                Container(
                                  height: sizeFromHeight(context, 6),
                                  width: sizeFromWidth(context, 4.6),
                                  margin: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            snapshot.data!.docs[index]['imageurl']),
                                        fit: BoxFit.cover,
                                      ),
                                      color: gray,
                                      borderRadius: BorderRadius.circular(23)),
                                ),
                                Text(
                                  snapshot.data!.docs[index]['bookname'],
                                  maxLines: 2,
                                  style: GoogleFonts.tajawal(
                                      textStyle: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis,

                                          color: gray,
                                          height: 1.5)),
                                ),
                              ],
                            ),
                          ),
                        );

                      },
                    ),
                  );
                }
              }
              return const CircularProgressIndicator();
            },
          ),
        )
    );
  }
}
