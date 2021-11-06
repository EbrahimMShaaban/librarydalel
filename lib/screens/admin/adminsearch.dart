import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/user/navigation.dart';
import 'book_list_screen/displaybook_item.dart';
import 'category_screen/view.dart';

class CategorySearchAdmin extends StatefulWidget {
  CategorySearchAdmin({Key? key}) : super(key: key);

  @override
  State<CategorySearchAdmin> createState() => _CategorySearchAdminState();
}

class _CategorySearchAdminState extends State<CategorySearchAdmin> {
  String? dropdownValue;

  var undropValue = 'null';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: purple,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Category()));
            },
            icon: Icon(Icons.arrow_back),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: DropdownButton<String>(
                hint: Text('بحث بالفئة',
                  textAlign: TextAlign.start,

                  style: buttonStyle,
                ),alignment: AlignmentDirectional.center,
                value: dropdownValue,
                underline: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 1,
                  decoration: const BoxDecoration(color: purple, boxShadow: [
                    BoxShadow(
                      color: purple,
                    )
                  ]),
                ),
                onChanged: (newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['الروايات', 'الادب', 'قدرات', 'لغات']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: SizedBox(
                      width:
                      MediaQuery
                          .of(context)
                          .size
                          .width - 65, // for example
                      child: Text(value, textAlign: TextAlign.right),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        body: dropdownValue == null
            ? const Center(
          child: Center(child: Text('اختار فئة للبحث')),
        )
            : StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('books')
                .where('type', isEqualTo: dropdownValue)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
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
              return const Text('حدث خطأ يرجى إعادة المحاولة');
            }));
  }
}
