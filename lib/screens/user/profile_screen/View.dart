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
  //ToDo
//غيرت اسم ال بروفايل  ل فيو
// عدلت المسافات و شيلت ال expand
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 25,
          ),
          Logo(height: 100,),
          SizedBox(height: 20),
          Center(
            child: Text(
              "الصفحة الشخصية",
              style: labelStyle,
            ),
          ),
          SizedBox(height: 50),
          UserItem(
            ": الأسم",
            textContainer: "الاسم",
          ),
          SizedBox(height: 30),
          UserItem(
            " : البريد الألكترونى  ",
            textContainer: "البريد الالكتروني",
          ),
          SizedBox(height: 70),
          EditButton("تعديل بياناتى", onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditProfile()));}),
          SizedBox(height: 20),
          Buton("تسجيل خروج", onTap: () {
            // Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) => LogInScreen()));
          }),
        ],
      ),
    );
  }
}
