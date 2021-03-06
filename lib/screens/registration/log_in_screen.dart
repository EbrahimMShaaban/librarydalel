// ignore_for_file: avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/alert.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/category_screen/view.dart';
import 'package:librarydalel/screens/registration/password_recovery.dart';
import 'package:librarydalel/screens/registration/sign_in_screen.dart';
import 'package:librarydalel/screens/user/navigation.dart';
import 'package:librarydalel/widgets/button/flatbuton.dart';
import 'package:librarydalel/widgets/button/textbuton.dart';
import 'package:librarydalel/widgets/input_field_regeist.dart';
import 'package:librarydalel/widgets/logo.dart';
class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  signIn() async {
    var formdata = _formKey.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        showLoading(context);
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        print(e.code);
        if (e.code == 'user-not-found') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "خطأ",
              body: const Text("لا يوجد حساب لهذا البريد الالكتروني"))
            .show();
        } else if (e.code == 'wrong-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "خطأ",
              body: const Text("كلمة المرور خطأ"))
            .show();
        }
        else if (e.code == 'invalid-email'){
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "خطأ",
              body: const Text("تم ادخال الايميل بشكل خاطيء"))
              .show();
        }
      }
    } else {
      return "Not Valid";
    }
  }
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          children: [
            const SizedBox(height: 35),
            const Logo(
            height: 140,
          ),
            const SizedBox(
        height: 30,
      ),
      Center(
          child: Text(
            'تسجيل الدخول',
            style: labelStyle,
          )),
            const SizedBox(
        height: 20,
      ),
      Form(
          key: _formKey,
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
                    return 'الرجاءإدخال البريد الالكتروني ';
                  }
                  if(!value.toString().contains('@')){
                    return ' الرجاء ادخال البريد الالكتروني بشكل صحيح يجب ان يحتوي @';
                  }
                  else if(!value.toString().contains('.com')){
                    return 'الرجاء ادخال البريد الالكتروني بشكل صحيح يجب ان مثل user@mail.com';
                  }
                 // else if(!value.toString().contains('gmail')){
                 //    return 'الرجاء ادخال البريد الالكتروني بشكل صحيح يجب ان يحتوي  gmail or mail or yahoo';
                 //  }
                 //  else if(!value.toString().contains('yahoo')){
                 //    return 'الرجاء ادخال البريد الالكتروني بشكل صحيح يجب ان يحتوي  gmail or mail or yahoo';
                 //  }
                 //  else if(!value.toString().contains('admin1')){
                 //    return 'الرجاء ادخال البريد الالكتروني بشكل صحيح يجب ان يحتوي  gmail or mail or yahoo';
                 //  }
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
                    return 'الرجاءإدخال كلمة المرور ';
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
              Navigator.push(
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
            height: sizeFromHeight(context, 15),
          ),
          Text(
            'ليس لديك حساب ؟',
            style: hintStyle,
          ),
        ],
      ),
      Buton("تسجيل دخول", onTap: ()async {
             await loginNavigate(context);
            },),
        ],
      ),
    );
  }
  loginNavigate(context)async{
    var user = await signIn();
    var uid= FirebaseAuth.instance.currentUser!.uid;
    if(user!= null && uid == 'DiSPLUCmVadcMDhjGsYJ5kvhvLQ2' ){
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context)=>const Category()));
    }
    else if(user != null){
      Navigator.of(context).popUntil((route) => route.isFirst);
      await  Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const NavigationScreen()));
    }
  }
}

