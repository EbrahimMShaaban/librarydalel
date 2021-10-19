// ignore_for_file: avoid_print, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/widgets/button/flatbuton.dart';
import 'package:librarydalel/widgets/input_field_regeist.dart';

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

    //Create field for user to input old password

    //pass the password here


    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: '${email}',
        password: password,
      );
      Navigator.pop(context);
      Navigator.pop(context);

      user.updatePassword(newPassword).then((_) {
        print("Successfully changed password");
      }

      ).catchError((error) {
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
      body: ListView(
        children: [
          const SizedBox(
            height: 70,
          ),
          Center(
            child: Text(
              "تعديل الملف الشخصى",
              style: labelStyle,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(onChanged: (val) {
                    password = val;
                  },
                    decoration: InputDecoration(

                      hintText: 'ادخل كلمةالمرورالقديم',
                      labelText: ' كلمة المرور القديم',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(onChanged: (val){
                     newPassword =val;
                  },
                    decoration: InputDecoration(
                        hintText: 'ادخل كلمة المرور الجديد',
                        labelText: 'كلمة المرور الجديدة'),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'تاكيد كلمة المرور الجديد',
                      labelText: 'تاكيد كلمة المرور الجديد',
                    ),
                    obscureText: true,
                  )
                ],
              )),
          const SizedBox(height: 80),
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
