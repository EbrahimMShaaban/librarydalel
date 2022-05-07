// ignore_for_file: avoid_print, use_key_in_widget_constructors, prefer_typing_uninitialized_variables

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/alert.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/category_screen/view.dart';
import 'package:librarydalel/screens/registration/log_in_screen.dart';
import 'package:librarydalel/screens/user/navigation.dart';
import 'package:librarydalel/widgets/button/flatbuton.dart';
import 'package:librarydalel/widgets/button/textbuton.dart';
import 'package:librarydalel/widgets/input_field_regeist.dart';
import 'package:librarydalel/widgets/logo.dart';

class NameValidator{
  static String? nameVal(String value){
       if (value.isEmpty) {
        return 'برجاءادخال الاسم';
      } else if (value.length < 3) {
        return 'يجب أن يتكون الاسم من 3 أحرف على الاقل';
      }
       return null;
  }
}class EmailValidator{
  static String? emailVal(String value){
    if (value.isEmpty) {
      return 'الرجاء إدخال بريد الكتروني';
    } else if (!value.toString().contains('@')) {
      return 'يجب  أن يحتوي البريد الايكتروني على @';
    }
       return null;
  }
}
class PasswordValidator{
  static String? passVal(String value){
    if (value.isEmpty) {
      return 'الرجاء إدخال كلمة مرور';
    }
  }
}
// class RePasswordValidator{
//   var sign= SignInScreen();
//    String? nameVal(String value){
//     if (value.isEmpty) {
//       return " الرجاء إعادة كتابة كلمة المرور";
//     }
//     else if (value != sign.password) {
//       return 'كلمة المرور غير متطابقة';
//     }
//     //todo: dosen't work😢
//     return null;
//   }
// }

class SignInScreen extends StatefulWidget {
  // const SignInScreen(this.id);
  //
  // final String id;

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  signUp() async {
    var formdata = _formKey.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        showLoading(context);
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
                  context: context,
                  title: "Error",
                  dialogType: DialogType.ERROR,
                  body: const Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                          "كلمة المرور ضعيفة يجب ان تتكون علي الاقل من ستة ارقام او حروف")))
              .show();
        } else if (e.code == 'email-already-in-use') {
          Navigator.of(context).pop();
          AwesomeDialog(
                  context: context,
                  title: "Error",
                  dialogType: DialogType.ERROR,
                  body: const Text(
                      "البريد الالكتروني موجود بالفعل ، الرجاء ادخال بريد اخر"))
              .show();
        }
      } catch (e) {
        print(e);
      }
    } else {}
  }


  var email, password, password2, name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 15,
          ),
          const Logo(
            height: 120,
          ),
          const SizedBox(
            height: 35,
          ),
          Center(
              child: Text(
            'تسجيل جديد',
            style: labelStyle,
          )),
          const SizedBox(
            height: 15,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                InputFieldRegist(
                  onChanged: (val) {
                   name = val;
                  },
                  hint: "ادخل اسمك",
                  label: " الاسم ",
                  scure: false,
                  validator: (value){
                   name = value;
                   return NameValidator.nameVal(value);
                  }

                  //     (value) {
                  //   if (value!.isEmpty) {
                  //     return 'برجاءادخال الاسم';
                  //   } else if (value.length < 3) {
                  //     return 'يجب أن يتكون الاسم من 3 أحرف على الاقل';
                  //   }
                  // },
                ),
                InputFieldRegist(
                  onChanged: (val) {
                email = val;
                  },
                  hint: "ادخل البريد الالكتروني....",
                  label: "البريد الالكتروني ",
                  scure: false,
                  validator: (value) {
                    email = value;
                  return  EmailValidator.emailVal(value);
                   // return null;

                  },
                ),
                InputFieldRegist(
                  onChanged: (val) {
                    password = val;
                  },
                  hint: "ادخل كلمة مرور",
                  label: "كلمة المرور ",
                  scure: true,
                  validator: (value) {
                    password = value;
                    return PasswordValidator.passVal(value);

                  },
                ),
                InputFieldRegist(
                  onChanged: (val) {
                   password2 = val;
                  },
                  hint: "أكد كلمة مرورك",
                  label: "تأكيد كلمة المرور ",
                  scure: true,
                  validator:
                      (value) {
                        password2 = value;
                        if (value.isEmpty) {
                          return " الرجاء إعادة كتابة كلمة المرور";
                        }
                        else if (value != password) {
                          return 'كلمة المرور غير متطابقة';
                        }

                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Buton(
            'تسجيل',
            onTap: () async {
              print(name);
              print(email);
              print(password);
              print(password2);
              UserCredential? response = await signUp();
              print("===================");
              print(name);
              print(email);
              print(password);
              print(password2);
              print("===================");
              // ignore: unnecessary_null_comparison
              if (response != null) {
                await FirebaseFirestore.instance.collection("users").add({
                  "username": name,
                  "email": email,
                  "userid": FirebaseAuth.instance.currentUser!.uid,
                });
                // await FirebaseFirestore.instance
                //     .collection('books')
                //     .doc(widget.id)
                //     .collection('comments')
                //     .add({
                //   "username": name,
                // });
                if (email == 'admin@admin1.com') {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Category()));
                } else {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const NavigationScreen()));
                }
              } else {
                print("Sign Up Faild");
              }
              print("===================");
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Textbuton('سجل دخول', onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LogInScreen()));
              }),
              Text(
                'هل لديك حساب بالفعل ؟',
                style: hintStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
