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
        if (e.code == 'user-not-found') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: const Text("No user found for that email"))
            .show();
        } else if (e.code == 'wrong-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: const Text("Wrong password provided for that user"))
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
                    return 'برجاء كتابه البريد الالكتروني بشكل صحيح';
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
            height: sizeFromHeight(context, 12),
          ),
          Text(
            'ليس لديك حساب ؟',
            style: hintStyle,
          ),
        ],
      ),



      Buton("تسجيل دخول", onTap: ()async {
        var user = await signIn();
        if (user != null && FirebaseAuth.instance.currentUser!.uid == 'XkbioiW6D8RT3tQPIr0u68cKnaq2') {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context)=>const Category()));
        }
        if(user != null  ) {
              await  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NavigationScreen()));
              }
            },),
        ],
      ),
    );
  }
}
