import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/widgets/addimage.dart';
import 'package:librarydalel/widgets/button/flatbuton.dart';
import 'package:librarydalel/widgets/input_field.dart';
import 'package:path/path.dart';

class AddBookScreen extends StatefulWidget {
  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  GlobalKey <FormState> _formKey = new GlobalKey<FormState>();
  var bookname, authorname, rownum, columnnum, type, imageurl;
  late File  file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(height: 50),
            Center(
                child: Text(
              'إضافة كتاب',
              style: labelStyle,
            )),
            SizedBox(height: 25),
            InputField(
              hint: 'ادخل اسم الكتاب',
              label: 'اسم الكتاب',
              scure: false,
              // onSaved: (value) {
              //   bookname = value;
              // },
            ),
            InputField(
              hint: 'ادخل اسم المؤلف',
              label: 'المؤلف',
              scure: false,
              // onSaved: (value) {
              //   authorname = value;
              // },
            ),
            InputField(
              hint: 'ادخل النوع',
              label: 'النوع',
              scure: false,
              // onSaved: (value) {
              //   type = value;
              // },
            ),
            InputField(
              hint: 'ادخل رقم العمود',
              label: 'رقم العمود',
              scure: false,
              // onSaved: (value) {
              //   columnnum = value;
              // },
            ),
            InputField(
              hint: 'ادخل رقم الصف',
              label: 'رقم الصف',
              scure: false,
              // onSaved: (value) {
              //   rownum = value;
              // },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: InkWell(
                onTap: (){
                  showBottomSheet(context);
                },
                child: Container(
                  height: sizeFromHeight(context, 15),
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Center(
                      child: Text(
                        'إضافة صورة ',
                        style: hintStyle,
                      )),
                  decoration: BoxDecoration(
                      color: white,
                      border: Border.all(
                        color: purple,
                        width: 2,
                      )),
                ),
              ),
            ),
            Buton('اضافة', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
showBottomSheet(context) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Please Choose Image",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () async {
                  var picked=  await ImagePicker().pickImage(source: ImageSource.gallery);


                },
                child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.photo_outlined,
                          size: 30,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "From Gallery",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    )),
              ),
              InkWell(
                onTap: () async{
                  var picked=  await ImagePicker().pickImage(source: ImageSource.camera);
                  if (picked != null) {
                    var file = File(picked.path);
                    var rand = Random().nextInt(100000);
                    var imagename = "$rand" + basename(picked.path);
                    Reference ref = FirebaseStorage.instance
                        .ref("images")
                        .child("$imagename");
                    Navigator.of(context).pop();
                  }

                },
                child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.camera,
                          size: 30,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "From Camera",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    )),
              ),
            ],
          ),
        );
      });
}