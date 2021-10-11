import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/widgets/button/flatbuton.dart';
import 'package:librarydalel/widgets/button/textbuton.dart';
import 'package:librarydalel/widgets/input_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'log_in_screen.dart';

class PasswordRecovery extends StatefulWidget {

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  TextEditingController editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
        child: ListView(
          children: [
            SizedBox(
              height: sizeFromHeight(context, 4),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                  child: Text(
                'استعادة كلمة المرور',
                style: labelStyle,
              )),
            ),
            Center(
                child: Text(
              'فضلا أدخل البريد الالكتروني',
              style: hintStyle,
            )),
            SizedBox(
              height: sizeFromHeight(context, 13),
            ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12.5),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              controller: editController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: purple, width: 2.5),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: purple, width: 2.5),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: "البريد الالكتروني",
                hintText: ' ادخل البريد الالكتروني',
                labelStyle: labelStyle,
                hintStyle: hintStyle,
              ),
            ),
          ),
        ),

            SizedBox(
              height: sizeFromHeight(context, 20),
            ),
            Buton(
              'ارسال',
              onTap: () {
            resetPassword(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Textbuton("تسجيل دخول", onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LogInScreen()));
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void resetPassword(BuildContext context) async {
    if (editController.text.length == 0 || !editController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Enter valid email",backgroundColor: purple);
      return;
    }

    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: editController.text);
    Fluttertoast.showToast(
        msg:
        "Reset password link has sent your mail please use it to change the password.",backgroundColor: purple,);
    Navigator.pop(context);
  }
}
