import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/category_screen/view.dart';
import 'package:librarydalel/widgets/button/flatbuton.dart';
import 'package:librarydalel/widgets/button/textbuton.dart';
import 'package:librarydalel/widgets/input_field_regeist.dart';
import 'package:librarydalel/widgets/logo.dart';


class SignInScreen extends StatefulWidget {
  // final void Function(String email, String password,BuildContext context, bool islogin) submit;
  // SignInScreen(this.submit);
  @override
  _SignInScreenState createState() => _SignInScreenState();
}
//ToDo

class _SignInScreenState extends State<SignInScreen> {
  // GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // validateForm() {
  //   print('aa');
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //     widget.submit(email,password,context,isLogin);
  //     print(email);
  //     print(password);
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => Category()));
  //   } else {
  //     return;
  //   }
  // }

final _auth = FirebaseAuth.instance;
  // bool modal_progress_hud = false;
  String email='';
  String password='';
  String name='';
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
          Column(
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
              InputFieldRegist(onChanged:(val){password=val;},
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
              // InputFieldRegist(
              //   onSaved: (){},
              //   hint: "أكد كلمة مرورك",
              //   label: "تأكيد كلمة المرور ",
              //   scure: true,
              //   validator: (value) {
              //
              //     if (value!.isEmpty) {
              //       return 'برجاء كتابه كلمة المرور بشكل صحيح';
              //     } else if (value.length < 5) {
              //       return 'برجاء كتابه كلمة المرور بشكل صحيح';
              //     }
              //   },
              // ),
            ],
          ),
          SizedBox(height: 20),
          Buton('تسجيل', onTap: () async {



            try {
              final newuser = await _auth.createUserWithEmailAndPassword(
                  email: email, password: password);
              if (newuser != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Category()));
              }

            } catch (e) {
              print(e);
              print("eroooooooooooooooooooooooooooooooooor");
            }
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Textbuton('سجل دخول', onTap: ()  {

              }
              ),
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
