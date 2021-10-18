import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';

import 'model.dart';

class Seerch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FirestoreSearchScaffold(
      firestoreCollectionName: 'books',
      searchBy: 'bookname',
      scaffoldBody: const Center(child: Text('Firestore Search')),
      dataListFromSnapshot: DataModel().dataListFromSnapshot,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<DataModel>? dataList = snapshot.data;

          return ListView.builder(
              itemCount: dataList?.length ?? 0,
              itemBuilder: (context, index) {
                final DataModel data = dataList![index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      height: sizeFromHeight(context, 7),
                      decoration: BoxDecoration(
                          color: purple,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: ListTile(
                          title: Text(
                            '${data.name}',
                            style: buttonStyle,
                          ),
                          subtitle: Text(
                            '${data.authname}',
                            style: hintStyle,
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
