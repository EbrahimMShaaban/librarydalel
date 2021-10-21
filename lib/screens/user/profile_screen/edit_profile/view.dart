// ignore_for_file: avoid_print, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/widgets/button/flatbuton.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var _formKey = GlobalKey<FormState>();
  String password = "";
  String newPassword = "";

  void _changePassword() async {
    var user = await FirebaseAuth.instance.currentUser!;
    var email = user.email;
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: '${email}',
        password: password,
      );

      user.updatePassword(newPassword).then((_) {
        print("Successfully changed password");
        Navigator.pop(context);
      }).catchError((error) {
        print("Password can't be changed" + error.toString());
        //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          "تعديل الملف الشخصى",
          style: appbarStyle,
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),color: purple,),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),

          Form(
              key: _formKey,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (val) {
                          password = val;
                        },
                        decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: purple, width: 2.5),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: purple, width: 2.5),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'ادخل كلمة المرور القديمة',
                          hintText: 'ادخل كلمة المرور القديمة',
                          labelStyle: labelStyle,
                          hintStyle: hintStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onChanged: (val) {
                          newPassword = val;
                        },
                        decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: purple, width: 2.5),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: purple, width: 2.5),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: ' كلمة المرور الجديدة',
                          hintText: 'ادخل كلمة المرور الجديدة',
                          labelStyle: labelStyle,
                          hintStyle: hintStyle,
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: purple, width: 2.5),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: purple, width: 2.5),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: ' كلمة المرور الجديدة',
                          hintText: 'ادخل كلمة المرور الجديدة',
                          labelStyle: labelStyle,
                          hintStyle: hintStyle,
                        ),
                        obscureText: true,
                      )
                    ],
                  ),
                ),
              )),
          const SizedBox(height: 50),
          Buton(
            "تعديل",
            onTap: () async {
              _changePassword();
            },
          ),
        ],
      ),
    );
  }
}
