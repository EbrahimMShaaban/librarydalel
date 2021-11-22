import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/wishes_screen/wish_details.dart';

class Wishes extends StatefulWidget {
  const Wishes({Key? key}) : super(key: key);

  @override
  _WishesState createState() => _WishesState();
}

class _WishesState extends State<Wishes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة الامنيات'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: white,
        titleTextStyle: labelStyle,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: gray,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('wishes').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WishesDetails(
                                    comment: snapshot.data!.docs[index]['comment'],
                                    image:  snapshot.data!.docs[index]['imageUrl'],
                                    name:  snapshot.data!.docs[index]['nameOfUser'],
                                  )));
                        },
                        child: Container(
                          width: sizeFromWidth(context, 1),
                          height: 150,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: white,
                            border: Border.all(color: purple),
                            boxShadow: const [
                              BoxShadow(color: purple, blurRadius: 3)
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'اسم المستخدم:',
                                            style: GoogleFonts.tajawal(
                                                textStyle: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: gray,
                                                    height: 1.5)),
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]
                                                ['nameOfUser'],
                                            style: GoogleFonts.tajawal(
                                                textStyle: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: gray,
                                                    height: 1.5)),
                                            maxLines: 3,
                                            overflow: TextOverflow.clip,
                                          ),
                                          Text(
                                            'التعليق:',
                                            style: GoogleFonts.tajawal(
                                                textStyle: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: gray,
                                                    height: 1.5)),
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]
                                                ['comment'],
                                            style: GoogleFonts.tajawal(
                                                textStyle: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: gray,
                                                    height: 1.5)),
                                            maxLines: 2,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: sizeFromHeight(context, 5),
                                    width: sizeFromWidth(context, 4),
                                    margin: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data!.docs[index]['imageUrl']),
                                          fit: BoxFit.cover,
                                        ),
                                        // color: gray,
                                        borderRadius:
                                            BorderRadius.circular(23)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
            return const Text('');
          }),
    );
  }
}
