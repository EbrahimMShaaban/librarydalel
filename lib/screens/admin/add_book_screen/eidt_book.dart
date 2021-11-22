// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

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
import 'package:path/path.dart';

class EditBook extends StatefulWidget {
  final docsid;
  final books;

  const EditBook({Key? key, required this.books, required this.docsid})
      : super(key: key);

  @override
  State<EditBook> createState() => _EditBookState();
}

class _EditBookState extends State<EditBook> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CollectionReference addbook = FirebaseFirestore.instance.collection("books");
  String? bookname, authorname, rownum, columnnum, type, imageurl, aboutBook;
  File? file;
  Reference? ref;

  editBook(context) async {
    var formdata = _formKey.currentState;
    if (file == null) {
      if (formdata!.validate()) {
        formdata.save();
        await addbook
            .doc(widget.docsid)
            .update({
              "bookname": bookname,
              "authorname": authorname,
              "rownum": rownum,
              "columnnum": columnnum,
              "type": type,
              'aboutBook': aboutBook,
            })
            .then((value) => () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DisplayBooksScreen()));
                })
            .catchError((e) {
              print("$e");
            });


      }
    } else {
      if (formdata!.validate()) {
        showLoading(context);
        formdata.save();
        await ref!.putFile(file!);
        imageurl = await ref!.getDownloadURL();
        await addbook
            .doc(widget.docsid)
            .update({
              "bookname": bookname,
              "authorname": authorname,
              "rownum": rownum,
              "columnnum": columnnum,
              "type": type,
              'imageurl': imageurl,
              'aboutBook': aboutBook,
            })
            .then((value) => () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DisplayBooksScreen()));
                })
            .catchError((e) {
              print("$e");
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        title: Text(
          'تعديل كتاب',
          style: buttonStyle2,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: gray,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              const SizedBox(height: 25),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  initialValue: widget.books.data()['bookname'],
                  onSaved: (val) {
                    bookname = val;
                  },
                  validator: (value) {
                    bookname = value;
                    if (value!.isEmpty) {
                      return 'الرجاءادخال اسم الكتاب ';
                    }
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: purple, width: 2.5),
                    ),
                    focusedBorder: const UnderlineInputBorder(
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
              const SizedBox(height: 25),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  initialValue: widget.books.data()['authorname'],
                  onSaved: (val) {
                    authorname = val;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'الرجاء ادخال اسم المؤلف';
                    }
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: purple, width: 2.5),
                    ),
                    focusedBorder: const UnderlineInputBorder(
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
              const SizedBox(height: 25),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  initialValue: widget.books.data()['type'],
                  onSaved: (val) {
                    type = val;
                  },
                  validator: (value) {
                    type = value;
                    if (value!.isEmpty) {
                      return 'الرجاءادخال النوع ';
                    }
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: purple, width: 2.5),
                    ),
                    focusedBorder: const UnderlineInputBorder(
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
              const SizedBox(height: 25),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  initialValue: widget.books.data()['columnnum'],
                  onSaved: (val) {
                    columnnum = val;
                  },
                  validator: (value) {
                    columnnum = value;
                    if (value!.isEmpty) {
                      return 'الرجاءادخال رقم العمود ';
                    }
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: purple, width: 2.5),
                    ),
                    focusedBorder: const UnderlineInputBorder(
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
              const SizedBox(height: 25),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  initialValue: widget.books.data()['rownum'],
                  onSaved: (val) {
                    rownum = val;
                  },
                  validator: (value) {
                    rownum = value;
                    if (value!.isEmpty) {
                      return 'الرجاء ادخال رقم الصف ';
                    }
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: purple, width: 2.5),
                    ),
                    focusedBorder: const UnderlineInputBorder(
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
              const SizedBox(height: 25),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  initialValue: widget.books.data()['aboutBook'],

                  onSaved: (val) {
                    aboutBook = val;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'الرجاءادخال نبذة عن الكتاب ';
                    }
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: purple, width: 2.5),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: purple, width: 2.5),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: ' نبذة عن الكتاب',
                    hintText: 'ادخل نبدة عن الكتاب',
                    labelStyle: labelStyle,
                    hintStyle: hintStyle,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: InkWell(
                  onTap: () {
                    showBottomSheet(context);
                  },
                  child: Container(
                    height: sizeFromHeight(context, 15),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              Buton('حفظ', onTap: () async {
                await editBook(context);
                await AwesomeDialog(
                        context: context,
                        title: "هام",
                        body: const Text("تمت عملية التعديل بنجاح"),
                        dialogType: DialogType.SUCCES)
                    .show();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DisplayBooksScreen()));
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
            padding: const EdgeInsets.all(20),
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
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
                          .child(imagename);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: const [
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
                          .child(imagename);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: const [
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
