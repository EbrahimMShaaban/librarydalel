import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/widgets/button/flatbuton.dart';
import 'package:librarydalel/widgets/input_field_regeist.dart';


class EditProfile extends StatefulWidget {
  late final String password;
  final TextEditingController passwordController = TextEditingController();

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  validateForm() {
    if (_formKey.currentState!.validate()) {
      print('login');
    } else {
      return;
    }
  }
late String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 70,
          ),
          Center(
            child: Text(
              "تعديل الملف الشخصى",
              style: labelStyle,
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Form(
            key: _formKey,
              child: Column(
            children: [
              InputFieldRegist(
                onSaved: (){},
                hint: 'ادخل كلمةالمرورالقديم',
                label: 'كلمة المرور القديم',
                scure: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'برجاء كتابه البريد الالكتروني بشكل صحيح';
                  } else if (value.length < 5) {
                    return 'برجاء كتابه البريد الالكتروني بشكل صحيح';
                  }
                },

              ),
              SizedBox(
                height: 20,
              ),
              InputFieldRegist(
                onSaved: (){},

                hint: 'ادخل كلمة المرور الجديد',
                label: 'كلمة المرور الجديد',
                scure: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'برجاء كتابه البريد الالكتروني بشكل صحيح';
                  } else if (value.length < 5) {
                    return 'برجاء كتابه البريد الالكتروني بشكل صحيح';
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              InputFieldRegist(
                onSaved: (){},
      
                hint: ' تاكيد كلمة المرورالجديد',
                label: ' تاكيد كلمة المرورالجديد',
                scure: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'برجاء كتابه البريد الالكتروني بشكل صحيح';
                  } else if (value.length < 5) {
                    return 'برجاء كتابه البريد الالكتروني بشكل صحيح';
                  }
                },
              ),
            ],
          )),
          SizedBox(height: 80),
          Buton(
            "تعديل",
            onTap: () {
              validateForm();
            },
          ),
        ],
      ),
    );
  }
}
