import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/widgets/addimage.dart';
import 'package:librarydalel/widgets/button/flatbuton.dart';
import 'package:librarydalel/widgets/input_field.dart';

class AddBookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 50
          ),
          Center(
              child: Text(
                'إضافة كتاب',
                style: labelStyle,
              )),
          SizedBox(
              height: 25
          ),
          InputField(hint:'ادخل اسم الكتاب', label: 'اسم الكتاب', scure: false),
          InputField(hint:'ادخل اسم المؤلف', label: 'المؤلف', scure: false),
          InputField(hint:'ادخل النوع', label: 'النوع', scure: false),
          InputField(hint:'ادخل رقم العمود', label: 'رقم العمود', scure: false),
          InputField(hint:'ادخل رقم الصف', label: 'رقم الصف', scure: false),
          AddImage(' + اضافة صورة '),
          Buton('اضافة',onTap: (){}),

        ],
      ),
    );
  }
}
