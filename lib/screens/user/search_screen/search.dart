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
          final List<DataModel>? dataList = snapshot.data;

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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookDetails(
                                          rownum: data.rownum  as dynamic,
                                          type: data.type  as dynamic,
                                          icon: null  as dynamic,
                                          bookname: data.name  as dynamic,
                                          id: data.id  as dynamic,
                                          colnum: data.colnum  as dynamic,
                                          image: data.imgurl  as dynamic,
                                          authname: data.authname  as dynamic,
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
