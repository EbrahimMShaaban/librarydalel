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
import 'package:awesome_dialog/awesome_dialog.dart';


class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // validateForm() async {
  //   print('aa');
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //     try {
  //       final newuser = await _auth.createUserWithEmailAndPassword(
  //           email: email, password: password);
  //       if (newuser != null) {
  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => NavigationScreen()));
  //       }
  //     } catch (e) {
  //       print(e);
  //       print("eroooooooooooooooooooooooooooooooooor");
  //     }
  //
  //     print(email);
  //     print(password);
  //   } else {
  //     return;
  //   }
  // }

  signUp() async {
    var formdata = _formKey.currentState;
    if (formdata!.validate()) {
      formdata.save();

      try {
        showLoading(context);
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: email, password: password);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("Password is to weak"))
            ..show();
        } else if (e.code == 'email-already-in-use') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("The account already exists for that email"))
            ..show();
        }
      } catch (e) {
        print(e);
      }
    } else {}
  }
  // final _auth = FirebaseAuth.instance;

  // bool modal_progress_hud = false;
  var email, password ,name ;

  // bool isLogin=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 15,
          ),
          Logo(
            height: 120,
          ),
          SizedBox(
            height: 35,
          ),
          Center(
              child: Text(
            'تسجيل جديد',
            style: labelStyle,
          )),
          SizedBox(
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'برجاءادخال الاسم';
                    } else if (value.length < 5) {
                      return 'برجاء كتابه الاسم بشكل صحيح';
                    }
                  },
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
                    if (value!.isEmpty) {
                      return 'برجاء كتابه البريد الالكتروني بشكل صحيح';
                    } else if (value.length < 5) {
                      return 'برجاء كتابه البريد الالكتروني بشكل صحيح';
                    }
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
                    if (value!.isEmpty) {
                      return 'برجاء كتابه كلمة المرور بشكل صحيح';
                    } else if (value.length < 5) {
                      return 'برجاء كتابه البريد الالكتروني بشكل صحيح';
                    }
                  },
                ),
                InputFieldRegist(
                  onChanged: (val) {
                    password = val;
                  },
                  hint: "أكد كلمة مرورك",
                  label: "تأكيد كلمة المرور ",
                  scure: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'برجاء كتابه كلمة المرور بشكل صحيح';
                    } else if (value.length < 5) {
                      return 'برجاء كتابه كلمة المرور بشكل صحيح';
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Buton(
            'تسجيل',
            onTap: ()  async {
              UserCredential response = await signUp();
              print("===================");
              if (response != null) {
                await FirebaseFirestore.instance
                    .collection("users")
                    .add({"username": name, "email": email});
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context)=>Category()));
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LogInScreen()));
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
