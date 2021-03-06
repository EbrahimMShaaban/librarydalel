// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/add_book_screen/deletebook.dart';
import 'package:librarydalel/screens/registration/log_in_screen.dart';
import 'package:librarydalel/screens/user/profile_screen/edit_profile/view.dart';
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
    //create instance from firebase firestore --> single tone
    await FirebaseFirestore.instance
        //go to (user) collection in fire store
        .collection('users')
        //get all docs and make for loop in it and get what i need ==> userid == my unique id
        .where('userid', isEqualTo: (FirebaseAuth.instance.currentUser!).uid)
        // get it
        .get()
        .then((value) {
      //this return a list of query snapshot , but it include a one item - because the firebase uid is unique for each user -
      print(value.docs[0]['username']);
      print("++///////=====================///////////////");
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
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('userid',
                    isEqualTo: (FirebaseAuth.instance.currentUser!).uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Logo(
                      height: 100,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        '?????????? ????????????',
                        style: labelStyle,
                      ),
                    ),
                    const SizedBox(height: 20),
                    UserItem(" : ??????????  ",
                        textContainer:
                            snapshot.data!.docs[0]['username'].toString()),
                    const SizedBox(height: 30),
                    UserItem(" : ???????????? ????????????????????  ",
                        textContainer:
                            snapshot.data!.docs[0]['email'].toString()),
                    const SizedBox(height: 30),
                    EditButton("?????????? ???????? ????????????", onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()));
                    }),
                    const SizedBox(height: 20),
                    Buton("?????????? ????????", onTap: () async {
                      showDialogWarning(context, text: '???? ?????? ?????????? ???? ?????????? ????????????', ontap: ()async{
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).popUntil((route) => route.isFirst);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const LogInScreen()));
                      });
                    }),
                  ],
                );
              } else {
                return const Text("");
              }
            }));
  }
}
