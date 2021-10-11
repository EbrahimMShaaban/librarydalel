import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/category_screen/view.dart';
import 'package:librarydalel/widgets/button/flatbuton.dart';
import 'package:librarydalel/widgets/button/textbuton.dart';
import 'package:librarydalel/widgets/input_field_regeist.dart';
import 'package:librarydalel/widgets/logo.dart';


class SignInScreen extends StatefulWidget {
  final void Function(String email, String password,BuildContext context, bool islogin) submit;
  SignInScreen(this.submit);
  @override
  _SignInScreenState createState() => _SignInScreenState();
}
//ToDo

class _SignInScreenState extends State<SignInScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  validateForm() {
    print('aa');
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.submit(email,password,context,isLogin);
      print(email);
      print(password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Category()));
    } else {
      return;
    }
  }

  // final _auth = FirebaseAuth.instance;
  // bool modal_progress_hud = false;
  String email='';
  String password='';
  String name='';
  bool isLogin=true;

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
                  // InputFieldRegist(
                  //
                  //   hint: "ادخل اسمك",
                  //   label: " الاسم ",
                  //   scure: false,
                  //   validator: (value) {
                  //     name = value;
                  //     if (value!.isEmpty) {
                  //       return 'برجاءادخال الاسم';
                  //     } else if (value.length < 5) {
                  //       return 'برجاء كتابه الاسم بشكل صحيح';
                  //     }
                  //   }, onSaved: (){},
                  // ),
                  InputFieldRegist(
                    onSaved: (){},
                    hint: "ادخل البريد الالكتروني",
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
                    onSaved: (){},
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
              )),
          SizedBox(height: 20),
          Buton('تسجيل', onTap: () {
            validateForm();
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Textbuton('سجل دخول', onTap: ()  {
                validateForm();
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
