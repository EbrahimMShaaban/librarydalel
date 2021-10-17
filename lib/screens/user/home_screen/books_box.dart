import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/book_details/view.dart';
class BooksBox extends StatefulWidget {
  final int length;

  const BooksBox(this.length, {Key? key}) : super(key: key);

  @override
  State<BooksBox> createState() => _BooksBoxState();
}

class _BooksBoxState extends State<BooksBox> {
  final CollectionReference bookref= FirebaseFirestore.instance.collection('books');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('books').get(),
          builder: (context,snapshot){
            if(snapshot.hasData){
               SizedBox(
                height: sizeFromHeight(context, 4),
                width: sizeFromWidth(context, 1),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.docs.length,
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
                                  bookname: snapshot.data!.docs[index],
                                  authname: snapshot.data!.docs[index],
                                  colnum: snapshot.data!.docs[index],
                                  type: snapshot.data!.docs[index],
                                  image: snapshot.data!.docs[index],
                                  rownum: snapshot.data!.docs[index],
                                )));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: sizeFromHeight(context, 6),
                            width: sizeFromWidth(context, 4.6),
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:  NetworkImage( snapshot.data!.docs[index]['imageurl']),
                                  fit: BoxFit.cover,
                                ),
                                color: gray,
                                borderRadius: BorderRadius.circular(23)),
                          ),
                          Text(
                            snapshot.data!.docs[index]['bookname'],
                            style: GoogleFonts.tajawal(
                                textStyle: const TextStyle(
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
              );
            }
            return const Text('eroooooor');
          },

        ),
      ),
    );
  }
}