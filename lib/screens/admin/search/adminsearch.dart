import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/add_book_screen/deletebook.dart';
import 'package:librarydalel/screens/admin/search/book_details.dart';
import 'package:librarydalel/screens/admin/search/eidt_book.dart';
import 'package:librarydalel/screens/admin/search/model.dart';

import '../category_screen/view.dart';

class CategorySearchAdmin extends StatefulWidget {
  CategorySearchAdmin({Key? key}) : super(key: key);


  @override
  State<CategorySearchAdmin> createState() => _CategorySearchAdminState();
}

class _CategorySearchAdminState extends State<CategorySearchAdmin> {
  String? dropdownValue;
  List<SearchModel> searchList = <SearchModel>[];
  List<SearchModel> searchList2 = <SearchModel>[];

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
   // searchList.clear();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('books')
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
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Category()));
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SizedBox(
                width: 300,
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
            ),

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   child: DropdownButton<String>(
                //     hint: Text(
                //       'بحث بالفئة',
                //       textAlign: TextAlign.start,
                //       style: buttonStyle,
                //     ),
                //     alignment: AlignmentDirectional.center,
                //     value: dropdownValue,
                //     underline: Container(
                //       width: 150,
                //       height: 1,
                //       decoration:
                //           const BoxDecoration(color: purple, boxShadow: [
                //         BoxShadow(
                //           color: purple,
                //         )
                //       ]),
                //     ),
                //     onChanged: (newValue ) async{
                //       setState(() {
                //         dropdownValue = newValue;
                //       });
                //        await getBook(dropdownValue!);
                //
                //     },
                //     items: <String>['الروايات', 'الادب', 'قدرات', 'لغات']
                //         .map<DropdownMenuItem<String>>((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: SizedBox(
                //           width: MediaQuery.of(context).size.width /
                //               3.5, // for example
                //           child: Text(value, textAlign: TextAlign.right,),
                //         ),
                //       );
                //     }).toList(),
                //   ),
                // ),

          ],
        ),
        
        body: searchList.isEmpty? const Center(child: Text('أدخل اسم كتاب للبحث'),):ListView.builder(
          itemCount:  searchList.length,
          itemBuilder: (context, index) {
            print(searchList.length);
            return filter == null || filter == ""
                ? _buildBookBox(
              searchList[index],
            ) :
              searchList[index]
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: white,
            boxShadow: const [BoxShadow(color: white, blurRadius: 6)],
            border: Border.all(color: purple, width: 1.5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "${searchModel.bookname}",
                  maxLines: 2,
                  style: GoogleFonts.tajawal(
                      textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: gray,
                  )),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: sizeFromWidth(context, 2),
                ),
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditBookSearch(
                                  aboutBook: searchModel.aboutBook,
                                  imageurl: searchModel.imageurl,
                                  columnnum: searchModel.columnnum,
                                  authorname: searchModel.authorname,
                                  bookname: searchModel.bookname,
                                  type: searchModel.type,
                                  rownum: searchModel.rownum,
                                  id: searchModel.id,
                                )));
                  },
                  child: const Icon(Icons.edit)),
              SizedBox(
                width: sizeFromWidth(context, 25),
              ),
              InkWell(
                  onTap: () {
                    showDialogWarning(context,
                        text: 'هل أنت متأكد من حذف الكتاب؟', ontap: () async {
                      await FirebaseFirestore.instance
                          .collection('books')
                          .doc(searchModel.id)
                          .delete();
                      await FirebaseFirestore.instance
                          .collection('books')
                          .doc(searchModel.id)
                          .collection('comments')
                          .get()
                          .then((snapshot) {
                        for (DocumentSnapshot ds in snapshot.docs) {
                          ds.reference.delete();
                        }
                      });

                      Navigator.pop(context);
                      AwesomeDialog(
                              context: context,
                              title: "هام",
                              body: const Text("تمت عملية الحذف بنجاح"),
                              dialogType: DialogType.SUCCES)
                          .show();
                    });
                  },
                  child: const Icon(Icons.delete))
            ],
          ),
        ),
      ),
    );
  }
}

