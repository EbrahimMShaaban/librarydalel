import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/book_details/view.dart';

import 'model.dart';

class Seerch extends StatelessWidget {
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

          return ListView.builder(
              itemCount: dataList?.length ?? 0,
              itemBuilder: (context, index) {
                 var data = dataList![index];

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
                            print((data.colnum as dynamic).runtimeType  );
                            print('===============/=====================');

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookDetails(
                                          rownum: data.rownum ,
                                          type: data.type  ,
                                          icon: null  ,
                                          bookname: data.name  ,
                                          id: data.id  ,
                                          colnum: data.colnum  ,
                                          image: data.imgurl ,
                                          authname: data.authname  ,
                                        )));
                          },
                          title: Text(
                            '${data.name}',
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
