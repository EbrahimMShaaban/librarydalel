import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/book_details/book_cover.dart';
import 'package:librarydalel/screens/admin/book_details/comments_item.dart';
import 'package:librarydalel/screens/admin/book_details/input_text.dart';


import 'model.dart';

class Seerch extends StatelessWidget {
  String? x = DataModel().name.toString();

  @override
  Widget build(BuildContext context) {
    return FirestoreSearchScaffold(
      firestoreCollectionName: 'books',
      searchBy: 'bookname',
      appBarBackgroundColor: purple,
      scaffoldBody: const Center(child: Text('Firestore Search')),
      dataListFromSnapshot: DataModel().dataListFromSnapshot,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<DataModel>? dataList = snapshot.data;
          dynamic name1 = dataList![0].name as String;
          dynamic columnnumber = dataList[0].colnum as String;
          dynamic rownumber = dataList[0].rownum as String;
          dynamic authername = dataList[0].authname as String;
          dynamic imageurl = dataList[0].imgurl as String;
          dynamic thetype = dataList[0].type as String;
          dynamic id1 = dataList[0].id as String;

          return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                var data = dataList[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      height: sizeFromHeight(context, 7),
                      decoration: BoxDecoration(
                          color: white2,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: ListTile(
                          onTap: () {

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                      backgroundColor: white,
                                      appBar: AppBar(
                                        elevation: 0,
                                        backgroundColor: white,
                                        title: Text(
                                          'عرض تفاصيل الكتاب',
                                          style: appbarStyle,
                                        ),
                                        centerTitle: true,
                                        leading: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(Icons.arrow_back),
                                          color: purple,
                                        ),
                                      ),
                                      body: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      InputText(
                                                        text: 'اسم الكتاب',
                                                        textDescribtion: data.name,
                                                      ),
                                                      InputText(
                                                        text: 'اسم المؤلف',
                                                        textDescribtion: data.authname,
                                                      ),
                                                      InputText(
                                                        text: 'رقم العمود ',
                                                        textDescribtion: data.colnum,
                                                      ),
                                                      InputText(
                                                        text: 'رقم الصف ',
                                                        textDescribtion: data.rownum,
                                                      ),
                                                      InputText(
                                                        text: 'نوع الكتاب ',
                                                        textDescribtion: data.type,
                                                      ),
                                                    ],
                                                  ),
                                                  BooKCover(
                                                    image:data.imgurl,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              SizedBox(
                                                  height: sizeFromHeight(context, 1.7),
                                                  child: FutureBuilder<QuerySnapshot>(

                                                    future: FirebaseFirestore.instance
                                                        .collection('books')
                                                        .doc(data.id)
                                                        .collection('comments')
                                                        .get(),
                                                    builder: (context, snapshot) {

                                                      if (snapshot.hasData) {
                                                        return ListView.builder(
                                                            itemCount: snapshot.data!.docs.length,
                                                            itemBuilder: (context, index) {
                                                              return CommentItem(
                                                                comment: snapshot.data!.docs[index]
                                                                ['comment'],

                                                                date: snapshot.data!.docs[index]['date']
                                                                    .toString(),

                                                              );
                                                            });
                                                      }
                                                      return const CircularProgressIndicator();
                                                    },
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),

                                    )));
                          },
                          title: Text(
                            '${data.name}' ,
                            style: labelStyle,
                          ),
                          subtitle: Text(
                            '${data.authname}',
                            style: labelStyle2,
                            //
                          ),
                          trailing: CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage('${data.imgurl}'),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        }

        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('No Results Returned'),
            );
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
