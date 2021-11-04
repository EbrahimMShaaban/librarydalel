import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:librarydalel/constant/styles.dart';

import 'book_details/view.dart';

class TopFour extends StatefulWidget {
  const TopFour({Key? key}) : super(key: key);

  @override
  State<TopFour> createState() => _TopFourState();
}

class _TopFourState extends State<TopFour> {
  @override
  Widget build(BuildContext context) {
    CollectionReference res = FirebaseFirestore.instance
        .collection('books')
        .doc('iaPJphqRdGPR66uZ1mk0')
        .collection('comments');
    @override
    void initState() {
      super.initState();
      print(res.snapshots().length);
      print("==================اااااااااااااااااااااااه=====================");
    }

    return Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('books')
                .orderBy("commentlength", descending: true)
                .limit(4)
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
                        return InkWell(
                          borderRadius: BorderRadius.circular(23),
                          highlightColor: purple,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookUserDetails(
                                          icon: Icons.add,
                                          id: snapshot.data!.docs[index].id,
                                          bookname: snapshot.data!.docs[index],
                                          authname: snapshot.data!.docs[index],
                                          colnum: snapshot.data!.docs[index],
                                          type: snapshot.data!.docs[index],
                                          image: snapshot.data!.docs[index],
                                          rownum: snapshot.data!.docs[index],
                                        )));
                          },
                          child: Container(
                            width: sizeFromWidth(context, 4),
                            child: Column(
                              children: [
                                Container(
                                  height: sizeFromHeight(context, 6),
                                  width: sizeFromWidth(context, 4.6),
                                  margin: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(snapshot
                                            .data!.docs[index]['imageurl']),
                                        fit: BoxFit.cover,
                                      ),
                                      color: gray,
                                      borderRadius: BorderRadius.circular(23)),
                                ),
                                Text(
                                  snapshot.data!.docs[index]['bookname'],
                                  maxLines: 1,

                                  style: GoogleFonts.tajawal(
                                      textStyle: const TextStyle(
                                          fontSize: 15,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w600,
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
        ));
  }
}
