import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'displaybook_item.dart';

class DisplayBooksScreen extends StatefulWidget {
  const DisplayBooksScreen({Key? key}) : super(key: key);

  @override
  State<DisplayBooksScreen> createState() => _DisplayBooksScreenState();
}

class _DisplayBooksScreenState extends State<DisplayBooksScreen> {
  CollectionReference bookref = FirebaseFirestore.instance.collection('books');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Text(
              'جميع الكتب',
              style: labelStyle,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 70,
              child: FutureBuilder<QuerySnapshot>(

                future: FirebaseFirestore.instance.collection('books').get(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState== ConnectionState.waiting){
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            onDismissed: (diretion) async {
                              await bookref
                                  .doc(snapshot.data!.docs[index].id)
                                  .delete();
                            },
                            key: UniqueKey(),

                            child: DisplaybookItem(
                              bookName: snapshot.data!.docs[index],
                              docsid: snapshot.data!.docs[index].id,
                              icon: Icons.add,
                              authname: snapshot.data!.docs[index],
                              colnum: snapshot.data!.docs[index],
                              type: snapshot.data!.docs[index],
                              image: snapshot.data!.docs[index],
                              rownum: snapshot.data!.docs[index],

                            ),
                          );
                        });
                  }
                  return const Text('erooor');
                },
              ),
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: purple,
      //   onPressed: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => const AddBookScreen()));
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
