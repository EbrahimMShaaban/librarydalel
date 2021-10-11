import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/widgets/button/flatbuton.dart';
import 'package:librarydalel/widgets/button/textbuton.dart';
import 'package:librarydalel/widgets/input_field.dart';


class PasswordRecovery extends StatelessWidget {
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
            InputField(
              hint: ' ادخل البريد الالكتروني',
              label: "البريد الالكتروني",
              scure: false,
            ),
            SizedBox(
              height: sizeFromHeight(context, 20),
            ),
            Buton(
              'ارسال',
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Textbuton("تسجيل دخول", onTap: () {
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => LogInScreen(submitAuthForm)));
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
