import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/registration/log_in_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final auth = FirebaseAuth.instance;
  @override
  void initState() {
    Timer(Duration(seconds: 10), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LogInScreen()));
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
              color: clear_gray,
              shape: BoxShape.circle,
              border: Border.all(color: clear_gray, width: 1.5),
              boxShadow: [BoxShadow(color: clear_gray, blurRadius: 3)]),
          child: CircleAvatar(
              backgroundColor: white,
              radius: 45,
              child: Image(
                  image: AssetImage(
                'assets/logo.png',
              ))),
        ),
      ),
    );
  }
}
