import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';

import 'input_text.dart';


class CommentItem extends StatefulWidget {
  const CommentItem({Key? key}) : super(key: key);

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeFromWidth(context, 1),
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: white,
        border: Border.all(color: purple),
        boxShadow: [BoxShadow(color: purple, blurRadius: 3)],
      ),
      child: Column(
        children: [
          Row(
            children: [InputText(text: 'اسم المستخدم', textDescribtion: ''),
              SizedBox(
                width: sizeFromWidth(context, 5),
              ),
              Text('20/10/2021',style: hintStyle,),
            ],
          ),
          Directionality(
            textDirection: TextDirection.rtl,
              child: Text('معني ان الغايه هي الشكل وليس المحتوي \n ويستخدم في صناعات المطابع  ',style: hintStyle,textDirection: TextDirection.rtl,))
        ],
      ),
    );
  }
}
