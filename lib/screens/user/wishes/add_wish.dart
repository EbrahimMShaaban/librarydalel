import 'dart:io';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:librarydalel/constant/alert.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/user/wishes/view.dart';
import 'package:librarydalel/widgets/button/flatbuton.dart';
import 'package:path/path.dart';

class AddWish extends StatefulWidget {
  AddWish({Key? key}) : super(key: key);

  @override
  _AddWishState createState() => _AddWishState();
}

class _AddWishState extends State<AddWish> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
var imageUrl;
  File? file;
  Reference? ref;
  var name;

  getUserName() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('userid', isEqualTo: (FirebaseAuth.instance.currentUser!).uid)
        .get()
        .then((value) {
      print(value.docs[0]['username']);
      print("++///////=====================///////////////");
      name = value.docs[0]['username'];
    });
  }

  addWish(context) async {
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
        formdata.save();
        showLoading(context);
        await ref!.putFile(file!);
        imageUrl = await ref!.getDownloadURL();
        await FirebaseFirestore.instance.collection('wishes').add({
          'nameOfUser': name,
          'imageUrl': imageUrl,
          'comment':controller.text,
          'userId':FirebaseAuth.instance.currentUser!.uid,
        }). then((value) {
          Navigator.pop(context);
          Navigator.pop(context);

        });


      }
    }
  }

  @override
  initState() {
    getUserName();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: white,
          elevation: 0,
          title: Text('إضافة أمنية ', style: appbarStyle),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: purple,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Text(
                "الرجاء ادخال صورة غلاف الكتاب وسنحاول جاهدين توفيره",
                style: textstyles,
                textDirection: TextDirection.rtl,
              ),
              // const SizedBox(
              //   height: 20,
              // ),
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
                      'إضافة صورةالغلاف ',
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
              Form(
                key: _formKey,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    onSaved: (value) {
                      // controller = value;
                    },
                    controller: controller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'برجاء اضافة تعليق';
                      }
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: 15,
                    maxLength: 200,
                    enableSuggestions: true,
                    decoration: InputDecoration(
                      fillColor: white,
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
              ),
              SizedBox(
                height: sizeFromHeight(context, 30),
              ),
              Buton('إرسال', onTap: () async {
                await addWish(context);
                await AwesomeDialog(
                    context: context,
                    title: "هام",
                    body: const Text("تمت عملية الاضافة بنجاح"),
                    dialogType: DialogType.SUCCES)
                    .show();
              })
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
