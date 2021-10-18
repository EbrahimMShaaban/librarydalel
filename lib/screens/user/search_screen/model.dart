import 'package:cloud_firestore/cloud_firestore.dart';

class DataModel {
  final String? name , authname , imgurl;


  DataModel({this.name,this.authname , this.imgurl});

  //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
  //This function in essential to the working of FirestoreSearchScaffold

  List<DataModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
      snapshot.data() as Map<String, dynamic>;
      print(dataMap['bookname']);
      print('============================================');
      return DataModel(
          name: dataMap['bookname'],
          authname: dataMap['authorname'],
          imgurl: dataMap['imageurl'],

          );
 }).toList();
  }
}