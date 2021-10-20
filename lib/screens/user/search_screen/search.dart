
import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/book_details/view.dart';

import 'model.dart';

class Seerch extends StatelessWidget {
  String? x = DataModel().name.toString() ;
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
                            print('================/====================');
                            print((data.colnum as dynamic).runtimeType);
                            print('===============/=====================');

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookDetails(
                                          rownum:  rownumber.toString(),
                                          type: thetype.toString(),
                                          icon: null,
                                          bookname: name1.toString(),
                                          id: id1.toString(),
                                          colnum: columnnumber.toString(),
                                          image: imageurl.toString(),
                                          authname: authername.toString(),
                                        )));
                          },
                          title: Text(
                            '${data.name }''$thetype' '$name1',
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
