// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/widgets/button/flatbuton.dart';
import 'package:librarydalel/widgets/logo.dart';

import 'edit_profile/edit_profile_button.dart';
import 'edit_profile/view.dart';
import 'user_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 25,
          ),
          const Logo(height: 100,),
          const SizedBox(height: 20),
          Center(
            child: Text(
              "الصفحة الشخصية",
              style: labelStyle,
            ),
          ),
          const SizedBox(height: 50),
          const UserItem(
            ": الأسم",
            textContainer: "الاسم",
          ),
          const  SizedBox(height: 30),
          const UserItem(
            " : البريد الألكترونى  ",
            textContainer: "البريد الالكتروني",
          ),
          const SizedBox(height: 70),
          EditButton("تعديل بياناتى", onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditProfile()));}),
          const SizedBox(height: 20),
          Buton("تسجيل خروج", onTap: () {
            // Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) => LogInScreen()));
          }),
        ],
      ),
    );
  }
}
