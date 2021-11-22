// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors, avoid_print

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';

import 'input_text.dart';

class CommentItem extends StatefulWidget {
  const CommentItem(
      {Key? key,
      this.id,
      required this.comment,
      required this.date,
      required this.name,
      this.length});

  final comment, date, name, length, id;

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  addLength() async {
    await FirebaseFirestore.instance
        .collection("books")
        .doc(widget.id)
        .update({"commentlength": widget.length});
  }

  @override
  void initState() {
    addLength();
    print(widget.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeFromWidth(context, 1),
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: white,
        border: Border.all(color: purple),
        boxShadow: const [BoxShadow(color: purple, blurRadius: 3)],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InputText(
                    text: 'اسم المستخدم',
                    textDescribtion: widget.name,
                    stl: textstyles,
                  ),
                ),
                // SizedBox(
                //   width: sizeFromWidth(context, 5),
                // ),
                Text(
                  widget.date,
                  style: textstyles,
                ),
              ],
            ),
            Text(
              widget.comment,
              style: hintStyle,
              textDirection: TextDirection.rtl,
            )

          ],
        ),
      ),
    );
  }
}
