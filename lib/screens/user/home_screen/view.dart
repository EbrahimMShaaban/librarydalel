import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/user/home_screen/topfour.dart';
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
        Expanded(
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
                  TopFour(),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      'روايات',
                      style: appbarStyle,
                    ),
                  ),
                  const BooksBox(type: 'الروايات'),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      'أدب',
                      style: appbarStyle,
                    ),
                  ),
                  const BooksBox(type: 'الادب'),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      'قدرات',
                      style: appbarStyle,
                    ),
                  ),
                  const BooksBox(type: 'قدرات'),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      'لغات',
                      style: appbarStyle,
                    ),
                  ),
                  const BooksBox(type: 'لغات')
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
