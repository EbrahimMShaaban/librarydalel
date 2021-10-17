import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/widgets/button/flatbuton.dart';
// ignore_for_file: use_key_in_widget_constructors


class AddComment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: purple,
          title: Center(child: Text('إضافة تعليق ', style: appbarStyle)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(

            children: [
              const SizedBox(
                height: 20,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  //onChanged: () {},
                  keyboardType: TextInputType.multiline,
                  maxLines: 15,
                  maxLength: 500,

                  enableSuggestions: true,

                  decoration: InputDecoration(
                    fillColor: clearGray,
                    isDense: false,

                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: purple, width: 2.0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: purple, width: 2.0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'اكتب تعليقك',



                    labelStyle: labelStyle,
                    hintStyle: hintStyle,
                  ),
                ),
              ),
              SizedBox(
                height: sizeFromHeight(context, 30),
              ),
              Buton('إرسال', onTap: () {
                Navigator.pop(context);
              })
            ],
          ),
        ),
      ),
    );
  }
}
