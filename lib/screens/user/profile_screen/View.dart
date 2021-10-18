// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/user/profile_screen/user_item.dart';
import 'package:librarydalel/widgets/button/flatbuton.dart';
import 'package:librarydalel/widgets/logo.dart';

import 'edit_profile/edit_profile_button.dart';
import 'edit_profile/view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseFirestore.instance.collection('books');
  final email = FirebaseAuth.instance.currentUser!.email;

  getUserName() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc((await FirebaseAuth.instance.currentUser!).uid)
        .get()
        .then((value) {
      setState(() {
        var _userName = value.data()!['username'];
        print(_userName);
        print('==========================');
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(( FirebaseAuth.instance.currentUser!).uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    const Logo(
                      height: 100,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        'الملف الشخصي',
                        style: labelStyle,
                      ),
                    ),
                    const SizedBox(height: 50),
                    const SizedBox(height: 30),
                    // UserItem(" : البريد الألكترونى  ",
                    //     textContainer: snapshot.data!['username'].toString()),
                    const SizedBox(height: 70),
                    EditButton("تعديل بياناتى", onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()));
                    }),
                    const SizedBox(height: 20),
                    Buton("تسجيل خروج", onTap: () {
                      print(snapshot.data!['username']);
                      // Navigator.pushReplacement(context,
                      //     MaterialPageRoute(builder: (context) => LogInScreen()));
                    }),
                  ],
                );
              } else {
                return const Text("reeeeeeeeeeeee");
              }
            }));
  }
}
