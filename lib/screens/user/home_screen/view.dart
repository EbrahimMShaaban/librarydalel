import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/widgets/logo.dart';

import 'books_box.dart';


class HomePageScren extends StatelessWidget {
  const HomePageScren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Center(
            child: Logo(
          height: 100,
        )),
        SizedBox(
          height: 20,
        ),
        Center(
            child: Text(
          'الصفحة الرئيسية ',
          style: labelStyle,
        )),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: sizeFromHeight(context, 1.4),
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
                  BooksBox(4),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      'روايات',
                      style: appbarStyle,
                    ),
                  ),
                  BooksBox(10),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      'أدب',
                      style: appbarStyle,
                    ),
                  ),
                  BooksBox(10),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      'قدرات',
                      style: appbarStyle,
                    ),
                  ),
                  BooksBox(10),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      'لغات',
                      style: appbarStyle,
                    ),
                  ),
                  BooksBox(10)
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
