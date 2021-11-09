// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'dart:io';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:librarydalel/constant/alert.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/book_list_screen/view.dart';
import 'package:librarydalel/widgets/button/flatbuton.dart';
import 'package:path/path.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({Key? key}) : super(key: key);

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CollectionReference addbook = FirebaseFirestore.instance.collection("books");
  var bookname, authorname, rownum, columnnum, type, imageurl ,aboutBook;
  File ?file;
  Reference ?ref;
  String? dropdownValue;

  var undropValue = 'null';

  addBook(context) async {
    if (file == null) {
      return AwesomeDialog(
          context: context,
          title: "هام",
          body: const Text("برجاء اختيار صورة"),
          dialogType: DialogType.ERROR)
        ..show();
    }
   else{
      var formdata = _formKey.currentState;
      if (formdata!.validate()) {
        print('==============');
        formdata.save();
        showLoading(context);
        print(context.hashCode);
        await ref!.putFile(file!);
        imageurl = await ref!.getDownloadURL();
        await addbook.add({
          "bookname": bookname,
          "authorname": authorname,
          "rownum": rownum,
          "columnnum": columnnum,
          "type": dropdownValue,
          "imageurl": imageurl,
          'aboutBook':aboutBook,
          "userid": FirebaseAuth.instance.currentUser!.uid,
          "bookid": Random().nextInt(100000),
        }).then((value) {


          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const DisplayBooksScreen()));
        }).catchError((e) {
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
          'إضافة كتاب',
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
              const SizedBox(height: 20),

              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  onSaved: (val) {
                    bookname = val;
                  },
                  validator: (value) {
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
                  onSaved: (val) {
                    authorname = val;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'الرجاءادخال اسم المؤلف ';
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ادخل النوع ',
                        style: labelStyle2,
                      ),
                      DropdownButton<String>(
                        hint: Text(
                          'الرجاء ادخال النوع',
                          style: hintStyle,
                        ),
                        value: dropdownValue,
                        underline: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          decoration:
                          const BoxDecoration(color: purple, boxShadow: [
                            BoxShadow(
                              color: purple,
                            )
                          ]),
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: <String>['الروايات', 'الادب', 'قدرات', 'لغات']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width -
                                  65, // for example
                              child: Text(value, textAlign: TextAlign.left),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ), // Directionality(
              const SizedBox(height: 25),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  onSaved: (val) {
                    columnnum = val;
                  },
                  validator: (value) {
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
                  onSaved: (val) {
                    rownum = val;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'الرجاءادخال رقم الصف ';
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                await addBook(context);
                await AwesomeDialog(
                    context: context,
                    title: "هام",
                    body: const Text("تمت عملية الاضافة بنجاح"),
                    dialogType: DialogType.SUCCES)
                    .show();

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

