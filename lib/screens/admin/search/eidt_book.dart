// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, must_be_immutable

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

class EditBookSearch extends StatefulWidget {
  String? bookname,
      authorname,
      rownum,
      columnnum,
      type,
      imageurl,
      aboutBook,
      id;

   EditBookSearch(
      {Key? key,

      required this.id,
      required this.bookname,
      required this.authorname,
      required this.aboutBook,
      required this.columnnum,
      required this.imageurl,
      required this.rownum,
      required this.type})
      : super(key: key);

  @override
  State<EditBookSearch> createState() => _EditBookSearchState();
}

class _EditBookSearchState extends State<EditBookSearch> {
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
            .doc(widget.id)
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

        // if (file == null){
        //   // if (formdata!.validate()) {
        //   //   formdata.save();
        //   //   showLoading(context);
        //   //   await addbook.doc().update({
        //   //     "bookname": bookname,
        //   //     "authorname": authorname,
        //   //     "rownum": rownum,
        //   //     "columnnum": columnnum,
        //   //     "type": type,
        //   //   }).then((value) {Navigator.push(context,
        //   //       MaterialPageRoute(builder: (context) => const DisplayBooksScreen()));}).catchError((e){
        //   //         print("$e");
        //   //   });}
        // }else{
        //
        //   }
      }
    } else {
      if (formdata!.validate()) {
        showLoading(context);
        formdata.save();
        await ref!.putFile(file!);
        imageurl = await ref!.getDownloadURL();
        await addbook
            .doc(widget.id)
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
          '?????????? ????????',
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
                  initialValue: widget.bookname,
                  onSaved: (val) {
                    bookname = val;
                  },
                  validator: (value) {
                    bookname = value;
                    if (value!.isEmpty) {
                      return '?????????????????????? ?????? ???????????? ';
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
                    labelText: '?????? ????????????',
                    hintText: '???????? ?????? ????????????',
                    labelStyle: labelStyle,
                    hintStyle: hintStyle,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  initialValue: widget.authorname,
                  onSaved: (val) {
                    authorname = val;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return '???????????? ?????????? ?????? ????????????';
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
                    labelText: '?????? ????????????',
                    hintText: '???????? ?????? ????????????',
                    labelStyle: labelStyle,
                    hintStyle: hintStyle,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  initialValue: widget.type,
                  onSaved: (val) {
                    type = val;
                  },
                  validator: (value) {
                    type = value;
                    if (value!.isEmpty) {
                      return '?????????????????????? ?????????? ';
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
                    labelText: '??????????',
                    hintText: '???????? ??????????',
                    labelStyle: labelStyle,
                    hintStyle: hintStyle,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  initialValue: widget.columnnum,
                  onSaved: (val) {
                    columnnum = val;
                  },
                  validator: (value) {
                    columnnum = value;
                    if (value!.isEmpty) {
                      return '?????????????????????? ?????? ???????????? ';
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
                    labelText: ' ?????? ????????????',
                    hintText: '???????? ?????? ????????????',
                    labelStyle: labelStyle,
                    hintStyle: hintStyle,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  initialValue: widget.rownum,
                  onSaved: (val) {
                    rownum = val;
                  },
                  validator: (value) {
                    rownum = value;
                    if (value!.isEmpty) {
                      return '???????????? ?????????? ?????? ???????? ';
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
                    labelText: ' ?????? ????????',
                    hintText: '???????? ?????? ????????',
                    labelStyle: labelStyle,
                    hintStyle: hintStyle,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  initialValue: widget.aboutBook,
                  onSaved: (val) {
                    aboutBook = val;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '?????????????????????? ???????? ???? ???????????? ';
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
                    labelText: ' ???????? ???? ????????????',
                    hintText: '???????? ???????? ???? ????????????',
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
                      '?????????? ???????? ',
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
              Buton('??????', onTap: () async {
                await editBook(context);
                await AwesomeDialog(
                        context: context,
                        title: "??????",
                        body: const Text("?????? ?????????? ?????????????? ??????????"),
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
