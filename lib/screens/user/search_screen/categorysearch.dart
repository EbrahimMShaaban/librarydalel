// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/search/book_details.dart';
import 'package:librarydalel/screens/admin/search/model.dart';

class CategorySearch extends StatefulWidget {
  const CategorySearch({Key? key}) : super(key: key);

  @override
  State<CategorySearch> createState() => _CategorySearchState();
}

class _CategorySearchState extends State<CategorySearch> {
  String? dropdownValue;
  List<SearchModel> searchList = <SearchModel>[];
  List<SearchModel> searchList2 = <SearchModel>[];

  TextEditingController searchController = TextEditingController();
  String? filter = '';
  // var undropValue = 'null';
  bool hasData = true;

  @override
  void initState() {
    getBook();
    searchController.addListener(() {
      filter = searchController.text;
      bool foundData = false;
      searchList.forEach((element) {
        if (element.bookname!.contains(filter!)) {
          hasData = true;
          foundData = true;
        }
      });

      if (foundData == false) {
        hasData = false;
      }

      setState(() {});
    });

    super.initState();
  }

  getBook() async {
    searchList.clear();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('books')
        // .where('type', isEqualTo: filter)
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
          aboutBook: doc['aboutBook'],
          id: doc.id));
    }
    print(searchList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: purple,
          title: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'ادخل اسم كتاب للبحث',
                hintStyle: labelStyle2,
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          leadingWidth: 1,
          automaticallyImplyLeading: false,

          // actions: [
          //   Row(
          //     children: [
          //
          //       // Padding(
          //       //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //       //   child: DropdownButton<String>(
          //       //     hint: Text(
          //       //       'بحث بالفئة',
          //       //       textAlign: TextAlign.start,
          //       //       style: buttonStyle,
          //       //     ),
          //       //     alignment: AlignmentDirectional.center,
          //       //     value: dropdownValue,
          //       //     underline: Container(
          //       //       width: 150,
          //       //       height: 1,
          //       //       decoration:
          //       //           const BoxDecoration(color: purple, boxShadow: [
          //       //         BoxShadow(
          //       //           color: purple,
          //       //         )
          //       //       ]),
          //       //     ),
          //       //     onChanged: (newValue) async {
          //       //       setState(() {
          //       //         dropdownValue = newValue;
          //       //       });
          //       //       await getBook(dropdownValue!);
          //       //     },
          //       //     items: <String>['الروايات', 'الادب', 'قدرات', 'لغات']
          //       //         .map<DropdownMenuItem<String>>((String value) {
          //       //       return DropdownMenuItem<String>(
          //       //         value: value,
          //       //         child: SizedBox(
          //       //           width: MediaQuery.of(context).size.width /
          //       //               3.5, // for example
          //       //           child: Text(
          //       //             value,
          //       //             textAlign: TextAlign.right,
          //       //           ),
          //       //         ),
          //       //       );
          //       //     }).toList(),
          //       //   ),
          //       // ),
          //     ],
          //   )
          // ],
        ),
        body: hasData
            ? ListView.builder(
                itemCount: searchList.length,
                itemBuilder: (context, index) {
                  hasData = searchList[index]
                      .bookname!
                      .toLowerCase()
                      .contains(filter!.toLowerCase());

                  return searchList[index]
                          .bookname!
                          .toLowerCase()
                          .contains(filter!.toLowerCase())
                      ? _buildBookBox(
                          searchList[index],
                        )
                      : Container();
                },
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:   [
                    Image(image: AssetImage('assets/booknot.png'),height: 200,),
                    Text("هذا الكتاب غير متوفر",style: labelStyle2,),
                  ],
                ),
              ));
  }

  Widget _buildBookBox(SearchModel searchModel) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookDetailsSearch(
                      bookname: searchModel.bookname,
                      icon: Icons.add,
                      type: searchModel.type,
                      image: searchModel.imageurl,
                      rownum: searchModel.rownum,
                      colnum: searchModel.columnnum,
                      authname: searchModel.authorname,
                      aboutBook: searchModel.aboutBook,
                      id: searchModel.id)));
        },
        child: Container(
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: white,
            boxShadow: const [BoxShadow(color: white, blurRadius: 6)],
            border: Border.all(color: purple, width: 1.5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              "${searchModel.bookname}",
              maxLines: 3,
              textAlign: TextAlign.center,
              style: GoogleFonts.tajawal(
                  textStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: gray,
              )),
            ),
          ),
        ),
      ),
    );
  }
}
