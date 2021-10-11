import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/category_screen/view.dart';
import 'package:librarydalel/screens/registration/password_recovery.dart';
import 'package:librarydalel/screens/registration/sign_in_screen.dart';
import 'package:librarydalel/widgets/button/flatbuton.dart';
import 'package:librarydalel/widgets/button/textbuton.dart';
import 'package:librarydalel/widgets/input_field_regeist.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  // final auth = FirebaseAuth.instance;
  //
  // void submit(
  //     String email, String password,BuildContext context, bool islogin) async {
  //
  //   try {UserCredential userCredential = await auth
  //         .createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  // GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //
  // validateForm() {
  //   print('aa');
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //     widget.submitAuth(email.trim(),password.trim(),context,isLogin);
  //
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => NavigationScreen()));
  //   } else {
  //     return;
  //   }
  // }

 final _auth = FirebaseAuth.instance;
//bool modal_progress_hud = false;
  String email = '';
  String password = '';
  // bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          children: [
          SizedBox(height: 35),
      // Logo(
      //   height: 140,
      // ),
      SizedBox(
        height: 30,
      ),
      Center(
          child: Text(
            'تسجيل الدخول',
            style: labelStyle,
          )),
      SizedBox(
        height: 20,
        //d
      ),
      Form(
          //key: _formKey,
          child: Column(
            children: [
              InputFieldRegist(
                onChanged: (val) {
                  email = val;
                },
                hint: 'ادخل البريد الالكتروني',
                label: 'البريد الالكتروني',
                scure: false,
                validator: (value) {
                  email = value;
                  if (value!.isEmpty) {
                    return 'برجاء كتابه البريد الالكتروني بشكل صحيح';
                  } else if (value.toString().contains('@')) {
                    return 'يجب ان يحتوي البريد الالكتروني علي @';
                  }
                },

              ),
              InputFieldRegist(
                onChanged: (val) {
                  password = val;
                },
                hint: 'ادخل كلمة المرور',
                label: 'كلمة المرور',
                scure: true,
                validator: (value) {
                  password = value;
                  if (value!.isEmpty) {
                    return 'برجاء كتابه كلمة المرور بشكل صحيح';
                  } else if (value.length < 5) {
                    return 'يجب ان نكون كلمة المرور تحتوي علي الاقل من خمس ارقام';
                  }
                },

              ),
            ],
          )),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Textbuton('هل نسيت كلمة المرور', onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PasswordRecovery()));
            })
          ],
        ),
      ),
      SizedBox(
        height: sizeFromHeight(context, 20),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Textbuton(
            'إنشاء حساب',
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SignInScreen()));
            },
          ),
          SizedBox(
            height: sizeFromHeight(context, 12),
          ),
          Text(
            'ليس لديك حساب ؟',
            style: hintStyle,
          ),
        ],
      ),
      Buton("تسجيل دخول", onTap: () async {

        try {
          final userLog = await _auth.signInWithEmailAndPassword(
              email: email, password: password);
          if (userLog != null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) =>  Category()));
          }

        } catch (e) {
          print(e);
          print("eroooooooooooooooooor");
        }
      }),
        ],
      ),
    );
  }
}
