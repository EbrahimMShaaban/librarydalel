import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/widgets/logo.dart';

import 'books_box.dart';


class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        const Center(
            child: Logo(
          height: 100,
        )),
        const SizedBox(
          height: 20,
        ),
        Center(
            child: Text(
          'الصفحة الرئيسية ',
          style: labelStyle,
        )),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height/1.8,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      'مقترحات الكتب',
                      style: appbarStyle,
                    ),
                  ),
                  // const BooksBox(type:'adab'),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      'روايات',
                      style: appbarStyle,
                    ),
                  ),
                  const BooksBox(type:'rawyat'),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      'أدب',
                      style: appbarStyle,
                    ),
                  ),
                  const BooksBox(type:'rawyat'),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      'قدرات',
                      style: appbarStyle,
                    ),
                  ),
                  const BooksBox(type:'adab'),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      'لغات',
                      style: appbarStyle,
                    ),
                  ),
                  const BooksBox(type:'adab')
                ],
            ),
          ],
          ),
        ),
    ],
      )
    );
  }
}
