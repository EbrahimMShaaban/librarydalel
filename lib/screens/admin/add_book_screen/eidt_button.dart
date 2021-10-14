import 'dart:io';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:librarydalel/constant/alert.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/book_list_screen/view.dart';
import 'package:librarydalel/widgets/button/flatbuton.dart';
import 'package:librarydalel/widgets/input_field.dart';
import 'package:path/path.dart';

class EditBook extends StatefulWidget {
  final docsid;
  final notes;

  EditBook ({required this.notes,required this.docsid});
  @override
  State<EditBook> createState() => _EditBookState();
}

class _EditBookState extends State<EditBook> {


  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  CollectionReference addbook =
  FirebaseFirestore.instance.collection("books");
  var bookname, authorname, rownum, columnnum, type, imageurl;
  late File file;
  late Reference ref;

  editNotes(context) async {
    var formdata = _formKey.currentState;
    if (file == null){
      if (formdata!.validate()) {
        formdata.save();
        showLoading(context);

        await addbook.doc().update({
          "bookname": bookname,
          "authorname": authorname,
          "rownum": rownum,
          "columnnum": columnnum,
          "type": type,
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DisplayBooksScreen()));
      }
    }else{
      if (formdata!.validate()) {
        formdata.save();
        showLoading(context);
        await ref.putFile(file);
        imageurl = await ref.getDownloadURL();
        await addbook.doc(widget.docsid).update({
          "bookname": bookname,
          "authorname": authorname,
          "rownum": rownum,
          "columnnum": columnnum,
          "type": type,
          "imageurl": imageurl,
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DisplayBooksScreen()));
      }
    };



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              SizedBox(height: 50),
              Center(
                  child: Text(
                    'إضافة كتاب',
                    style: labelStyle,
                  )),
              SizedBox(height: 25),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  initialValue: widget.notes['bookname'],

                  onSaved: (val) {
                    bookname = val;
                  },
                  validator: (value) {
                    bookname = value;
                    if (value!.isEmpty) {
                      return 'برجاءادخال اسم الكتاب ';
                    }
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: purple, width: 2.5),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: purple, width: 2.5),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,

                    labelText: 'اسم الكتاب',
                    hintText: 'ادخل اسم الكتاب',
                    labelStyle: labelStyle,
                    hintStyle: hintStyle,
                  ),
                ),
              ),

              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  initialValue: widget.notes['authorname'],
                  onSaved: (val) {
                    authorname = val;
                  },
                  validator: (value) {
                    authorname = value;
                    if (value!.isEmpty) {
                      return 'برجاءادخال اسم المؤلف ';
                    }
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: purple, width: 2.5),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: purple, width: 2.5),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'اسم المؤلف',
                    hintText: 'ادخل اسم المؤلف',
                    labelStyle: labelStyle,
                    hintStyle: hintStyle,
                  ),
                ),
              ),

              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  initialValue: widget.notes['type'],

                  onSaved: (val) {
                    type = val;
                  },
                  validator: (value) {
                    type = value;
                    if (value!.isEmpty) {
                      return 'برجاءادخال النوع ';
                    }
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: purple, width: 2.5),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: purple, width: 2.5),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'النوع',
                    hintText: 'ادخل النوع',
                    labelStyle: labelStyle,
                    hintStyle: hintStyle,
                  ),
                ),
              ),


              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  initialValue: widget.notes['columnnum'],

                  onSaved: (val) {
                    columnnum = val;
                  },
                  validator: (value) {
                    columnnum = value;
                    if (value!.isEmpty) {
                      return 'برجاءادخالرقم العمود ';
                    }
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: purple, width: 2.5),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: purple, width: 2.5),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: ' رقم العمود',
                    hintText: 'ادخل رقم العمود',
                    labelStyle: labelStyle,
                    hintStyle: hintStyle,
                  ),
                ),
              ),


              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  initialValue: widget.notes['rownum'],

                  onSaved: (val) {
                    rownum = val;
                  },
                  validator: (value) {
                    rownum = value;
                    if (value!.isEmpty) {
                      return 'برجاءادخال رقم الصف ';
                    }
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: purple, width: 2.5),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: purple, width: 2.5),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: ' رقم الصف',
                    hintText: 'ادخل رقم الصف',
                    labelStyle: labelStyle,
                    hintStyle: hintStyle,
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                child: InkWell(
                  onTap: () {
                    showBottomSheet(context);
                  },
                  child: Container(
                    height: sizeFromHeight(context, 15),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              Buton('اضافة', onTap: () async {
                await editNotes(context);
              }),
            ],
          ),
        ),
      ),
    );
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
                    var picked = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (picked != null) {
                      file = File(picked.path);
                      var rang = Random().nextInt(100000);
                      var imagename = "$rang" + basename(picked.path);
                      ref = FirebaseStorage.instance
                          .ref("images")
                          .child("${imagename}");
                      Navigator.of(context).pop();
                    }
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
                  onTap: () async {
                    var picked = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (picked != null) {
                      file = File(picked.path);
                      var rang = Random().nextInt(100000);
                      var imagename = "$rang" + basename(picked.path);
                      ref = FirebaseStorage.instance
                          .ref("images")
                          .child("${imagename}");
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
}
