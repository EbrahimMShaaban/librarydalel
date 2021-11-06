// ignore_for_file: avoid_print, use_key_in_widget_constructors

import 'package:awesome_dialog/awesome_dialog.dart';
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
  String newPasswordCheck='';

  void _changePassword() async {
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      var user = await FirebaseAuth.instance.currentUser!;
      var email = user.email;
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: '${email}',
          password: password,
        );

        user.updatePassword(newPasswordCheck).then((_) {
          AwesomeDialog(
              context: context,
              // title: "خطأ",
              dialogType: DialogType.SUCCES,
              aligment: Alignment.center,
              body: Center(child:Text("تم تغيير كلمة المرور بنجاح")))
              .show();
          print("Successfully changed password");
        }).catchError((error) {
          print("Password can't be changed" + error.toString());
          //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          AwesomeDialog(
              context: context,
              title: "خطأ",
              dialogType: DialogType.ERROR,
              body: const Text("كلمة المرور خطأ"))
              .show();
          print('Wrong password provided for that user.');
        }
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          "تعديل كلمة المرور",
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
                      // for old password
                      TextFormField(
                        onChanged: (val) {
                          password = val;
                        },
                        validator: (val){
                          if(val!.isEmpty){
                            return 'الرجاء ادخال كلمة المرور';
                          }
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
                        validator: (val){
                          if(val!.isEmpty){
                            return 'الرجاءادخال كلمة المرور الجديدة';
                          }
                          if(val.length<5){
                            return 'يجب ان تحتوي كلمة المرور علي الاقل خمسة ارقام ';
                          }
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
                        onChanged: (val) {
                          newPasswordCheck = val;
                        },
                        validator: (val){
                          if(val!.isEmpty){
                            return 'الرجاءتأكيد كلمة المرور الجديدة';
                          }
                          if(val.length<5){
                            return 'يجب ان تحتوي كلمة المرور علي الاقل خمسة ارقام ';
                          }
                          if(newPasswordCheck!=newPassword){
                            return'كلمة المرور غير متطابقة';
                          }
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
                      )
                    ],
                  ),
                ),
              )),
          const SizedBox(height: 50),
          Buton(
            "تعديل",
            onTap: () async {
              // if(_formKey.currentState!.validate()){
              //   _formKey.currentState!.save();
              //
              // }
              _changePassword();
            },
          ),
        ],
      ),
    );
  }
}
