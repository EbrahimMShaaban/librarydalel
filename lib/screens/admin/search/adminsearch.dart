import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/search/model.dart';

import '../book_list_screen/displaybook_item.dart';
import '../category_screen/view.dart';

class CategorySearchAdmin extends StatefulWidget {
  CategorySearchAdmin({Key? key}) : super(key: key);

  @override
  State<CategorySearchAdmin> createState() => _CategorySearchAdminState();
}

class _CategorySearchAdminState extends State<CategorySearchAdmin> {
  String? dropdownValue;
  List<SearchModel> searchList = <SearchModel>[];
  TextEditingController searchController = TextEditingController();
  String? filter = '';
  var undropValue = 'null';

  @override
  void initState() {
    getBook();
    searchController.addListener(() {
      filter = searchController.text;
      setState(() {});
    });

    super.initState();
  }

  getBook() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('books')
        .where('type', isEqualTo: dropdownValue)
        .get();

    for (var doc in querySnapshot.docs) {
      searchList.add(SearchModel(
          bookid: doc['bookid'],
          rownum: doc['rownum'],
          type: doc['type'],
          bookname: doc['bookname'],
          authorname: doc['authorname'],
          columnnum: doc['columnnum'],
          imageurl: doc['imageurl'],
          userid: doc['userid'],
          id: doc.id));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: purple,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Category()));
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButton<String>(
                    hint: Text(
                      'بحث بالفئة',
                      textAlign: TextAlign.start,
                      style: buttonStyle,
                    ),
                    alignment: AlignmentDirectional.center,
                    value: dropdownValue,
                    underline: Container(
                      width: 150,
                      height: 1,
                      decoration:
                          const BoxDecoration(color: purple, boxShadow: [
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
                          width: MediaQuery.of(context).size.width /
                              3.5, // for example
                          child: Text(value, textAlign: TextAlign.right),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            )
          ],
        ),
        body: dropdownValue == null
            ? const Center(
                child: Center(child: Text('اختار فئة للبحث')),
              )
            : ListView.builder(
                itemCount: searchList.length,
                itemBuilder: (context, index) {
                  return filter == null || filter == ""
                      ? _buildBookBox(
                          searchList[index],
                        )
                      : searchList[index]
                              .bookname!
                              .toLowerCase()
                              .contains(filter!.toLowerCase())
                          ? _buildBookBox(
                              searchList[index],
                            )
                          : Container();
                },
              ));
  }

  Widget _buildBookBox(SearchModel searchModel) {
    return DisplaybookItem(
      bookName: searchModel.bookname,
      docsid: searchModel.id,
      icon: Icons.add,
      authname: searchModel.authorname,
      colnum: searchModel.columnnum,
      type: searchModel.type,
      image: searchModel.imageurl,
      rownum: searchModel.rownum,
    );
  }
}
// ListView.builder(
// itemCount: snapshot.data!.docs.length,
// itemBuilder: (context, index) {
// return DisplaybookItem(
// bookName: snapshot.data!.docs[index],
// docsid: snapshot.data!.docs[index].id,
// icon: Icons.add,
// authname: snapshot.data!.docs[index],
// colnum: snapshot.data!.docs[index],
// type: snapshot.data!.docs[index],
// image: snapshot.data!.docs[index],
// rownum: snapshot.data!.docs[index],
// );
// });
