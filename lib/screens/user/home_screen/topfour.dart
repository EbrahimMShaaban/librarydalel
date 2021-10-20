import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TopFour extends StatefulWidget {
  const TopFour({Key? key}) : super(key: key);

  @override
  State<TopFour> createState() => _TopFourState();
}

class _TopFourState extends State<TopFour> {
  @override
  Widget build(BuildContext context) {
    CollectionReference res = FirebaseFirestore.instance
        .collection('books')
        .doc('iaPJphqRdGPR66uZ1mk0')
        .collection('comments');
    @override
    void initState() {
      super.initState();
      print(res.snapshots().length);
      print("==================اااااااااااااااااااااااه=====================");
    }

    return StreamBuilder<QuerySnapshot>(
      stream: res.snapshots(),

      builder: (Context, snapshot) {
        assert(Context != null);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('erroooooor');
          }
          if (snapshot.hasData) {
            for (var y in snapshot.data!.docs) {
              print(snapshot.data!.size);
              print("======================================");
              print(snapshot.data!.docs.length);
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('${snapshot.data!.docs[index]['comment']}'),
                  );
                });
          }
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
