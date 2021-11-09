import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/add_book_screen/deletebook.dart';
import 'package:librarydalel/screens/user/wishes/add_wish.dart';

class WishesScreen extends StatefulWidget {
  const WishesScreen({Key? key}) : super(key: key);

  @override
  _WishesScreenState createState() => _WishesScreenState();
}

class _WishesScreenState extends State<WishesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة الامنيات'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: white,
        titleTextStyle: labelStyle,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('wishes')
              .where('userId',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: sizeFromWidth(context, 1.2),
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
                            child: SingleChildScrollView(
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
                                                'التعليق:',
                                                style: GoogleFonts.tajawal(
                                                    textStyle: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: gray,
                                                        height: 1.5)),
                                              ),
                                              Text(
                                                snapshot.data!.docs[index]
                                                    ['comment'],
                                                style: GoogleFonts.tajawal(
                                                    textStyle: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: gray,
                                                        height: 1.5)),
                                                maxLines: 3,
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
                                              image: NetworkImage(snapshot.data!
                                                  .docs[index]['imageUrl']),
                                              fit: BoxFit.cover,
                                            ),
                                            color: gray,
                                            borderRadius:
                                                BorderRadius.circular(23)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                            child: IconButton(
                              onPressed: () async {
                                await showDialogWarning(context,
                                    text: 'هل انت متاكد من الحذف ',
                                    ontap: () async {
                                  await FirebaseFirestore.instance
                                      .collection('wishes')
                                      .doc(snapshot.data!.docs[index].id)
                                      .delete();

                                  // setState(() {
                                  //
                                  // });

                                  Navigator.pop(context);
                                  AwesomeDialog(
                                          context: context,
                                          title: "هام",
                                          body: const Text(
                                              "تمت عملية الحذف بنجاح"),
                                          dialogType: DialogType.SUCCES)
                                      .show();
                                });
                              },
                              icon: const Icon(Icons.delete),
                              color: const Color(0xffCC0000),
                              iconSize: 35,
                            ),
                          )
                        ],
                      ),
                    );
                  });
            }
            return const Text('');
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: purple,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddWish()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
