// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/add_book_screen/add_book_screen.dart';
import 'package:librarydalel/screens/admin/category_screen/view.dart';
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
      appBar: AppBar(
        backgroundColor: purple,
        title: Text(
          'جميع الكتب',
          style: buttonStyle,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const Category()));
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('books').snapshots(),
                builder: (context, AsyncSnapshot <QuerySnapshot>snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('');
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return DisplaybookItem(
                            bookName: snapshot.data!.docs[index],
                            docsid: snapshot.data!.docs[index].id,
                            icon: Icons.add,
                            authname: snapshot.data!.docs[index],
                            colnum: snapshot.data!.docs[index],
                            type: snapshot.data!.docs[index],
                            image: snapshot.data!.docs[index],
                            rownum: snapshot.data!.docs[index],
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
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: purple,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddBookScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
