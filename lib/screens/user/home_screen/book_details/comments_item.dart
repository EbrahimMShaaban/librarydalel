// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'input_text.dart';


class CommentItem extends StatefulWidget {
  final comment, date;
  const CommentItem({Key? key, required this.comment ,required this.date}) : super(key: key);

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeFromWidth(context, 1),
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: white,
        border: Border.all(color: purple),
        boxShadow: const [BoxShadow(color: purple, blurRadius: 3)],
      ),
      child: Column(
        children: [
          Row(
            children: [const InputText(text: 'اسم المستخدم', textDescribtion: ''),
              SizedBox(
                width: sizeFromWidth(context, 5),
              ),
              Text(widget.date,style: hintStyle2,),
            ],
          ),
          Directionality(
            textDirection: TextDirection.rtl,
              child: Text(widget.comment,style: hintStyle,textDirection: TextDirection.rtl,))
        ],
      ),
    );
  }
}
