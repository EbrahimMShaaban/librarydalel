import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/add_book_screen/add_book_screen.dart';
import 'package:librarydalel/screens/admin/add_book_screen/deletebook.dart';
import 'package:librarydalel/screens/admin/book_list_screen/view.dart';
import 'package:librarydalel/screens/registration/log_in_screen.dart';
import 'package:librarydalel/screens/user/search_screen/search.dart';

import '../adminsearch.dart';
import 'category_item.dart';
import 'custom_appBar.dart';


class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          myAppBar(),
          SizedBox(
            height: sizeFromHeight(context, 5),
          ),
          CategoryItem(
            text: 'الكتب',
            onTap: () async{
            await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DisplayBooksScreen()));
            },
          ),
          CategoryItem(
            text: 'اضافة كتاب',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  const AddBookScreen()));
            },
          ),
          CategoryItem(
            text: 'بحث ',
            onTap: () async{
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  CategorySearchAdmin()));
            },
          ),
          CategoryItem(
            text: 'تسجيل خروج',

              onTap: () async {
              showDialogWarning(context, text: 'هل انت متاكد من تسجيل الخروج', ontap: ()async{
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LogInScreen()));
              });


            },
          ),
        ],
      ),
    );
  }
}
