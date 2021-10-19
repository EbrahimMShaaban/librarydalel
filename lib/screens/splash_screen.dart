import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/main.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final auth = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    Timer(const Duration(seconds: 10), () {
       login(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: sizeFromWidth(context, 2),
          height: sizeFromHeight(context, 2),
          decoration: BoxDecoration(
              color: clearGray,
              shape: BoxShape.circle,
              border: Border.all(color: clearGray, width: 1.5),
              boxShadow: const  [BoxShadow(color: clearGray, blurRadius: 3)]),
          child:  const CircleAvatar(
              backgroundColor: white,
              radius: 45,
              child:  Image(
                  image:  AssetImage(
                'assets/logo3.png',
              ))),
        ),
      ),
    );
  }
}
