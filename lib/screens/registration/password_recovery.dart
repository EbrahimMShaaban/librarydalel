// ignore_for_file: use_key_in_widget_constructors

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/registration/user_model.dart';
import 'package:librarydalel/widgets/button/flatbuton.dart';
import 'package:librarydalel/widgets/button/textbuton.dart';
import 'package:librarydalel/widgets/logo.dart';

import 'log_in_screen.dart';

class PasswordRecovery extends StatefulWidget {
  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  TextEditingController editController = TextEditingController();
  List<UsersModel> users = <UsersModel>[];

  @override
  void initState() {
    getUsers();
    setState(() {});
    // TODO: implement initState
    super.initState();
  }

  getUsers() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    for (var doc in querySnapshot.docs) {
      print(doc['email']);
      users.add(UsersModel(
        email: doc['email'],
        userName: doc['username'],
        userid: doc['userid'],
      ));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon:const  Icon(Icons.arrow_back,color: purple,)),
      ),
      body: ListView(
        children: [
          //  SizedBox(
          //   height: 30,
          // ),
          Logo(height: 100),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Center(
                child: Text(
              'استعادة كلمة المرور',
              style: labelStyle,
            )),
          ),
          Center(
              child: Text(
            'فضلا أدخل البريد الالكتروني',
            style: hintStyle,
          )),
          SizedBox(
            height: sizeFromHeight(context, 13),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12.5),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: editController,
                decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: purple, width: 2.5),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: purple, width: 2.5),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: "البريد الالكتروني",
                  hintText: ' ادخل البريد الالكتروني',
                  labelStyle: labelStyle,
                  hintStyle: hintStyle,
                ),
              ),
            ),
          ),
          SizedBox(
            height: sizeFromHeight(context, 20),
          ),
          Buton(
            'ارسال',
            onTap: () {
              resetPassword(context);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Textbuton("تسجيل دخول", onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LogInScreen()));
                }),
              ],
            ),
          )
        ],
      ),
    );
  }

  void resetPassword(BuildContext context) async {
    if (editController.text.isEmpty || !editController.text.contains("@")) {
      AwesomeDialog(
              context: context,
              title: "هام",
              body: const Text("إيميل الاستعادة خاطيء"),
              dialogType: DialogType.ERROR)
          .show();
      // Fluttertoast.showToast(msg: "Enter valid email", backgroundColor: purple);
      return;
    }

    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: editController.text);
    AwesomeDialog(
            context: context,
            title: "هام",
            body: const Text(
                "الرجاء التحقق من بريديك الالكتروني لتغيير كلمة المرور"),
            dialogType: DialogType.SUCCES)
        .show();
    // Fluttertoast.showToast(
    //   msg:
    //       "Reset password link has sent your mail please use it to change the password.",
    //   backgroundColor: purple,
    // );
    // Navigator.pop(context);
  }
}
