import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/add_book_screen/add_book_screen.dart';
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
            SizedBox(
              height: 60,
            ),
            Text('جميع الكتب',style: labelStyle,),
            SizedBox(
              height: MediaQuery.of(context).size.height-70,
              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection('books').get(),
                  builder: (context,snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return DisplaybookItem();
                    });
                  }
                  return Text('erooor');
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
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddBookScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// ListView.builder(
// itemCount: 20,
// itemBuilder: (context, index) {
// return DisplaybookItem();
// }),
