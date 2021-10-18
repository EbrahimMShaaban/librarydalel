// ignore_for_file: use_key_in_widget_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/screens/admin/add_book_screen/add_book_screen.dart';
import 'package:librarydalel/screens/registration/log_in_screen.dart';
import 'package:librarydalel/screens/registration/sign_in_screen.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // var user = FirebaseAuth.instance.currentUser;
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogInScreen(),
    );
  }
}



