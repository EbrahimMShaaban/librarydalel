// ignore_for_file: use_key_in_widget_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/screens/admin/category_screen/view.dart';
import 'package:librarydalel/screens/registration/log_in_screen.dart';
import 'package:librarydalel/screens/splash_screen.dart';
import 'package:librarydalel/screens/user/navigation.dart';

late  bool islogin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    islogin = false;
  } else {
    islogin = true;
  }

  runApp(MyApp());
}
 login(context){
   if(islogin== false){
     Navigator.pushReplacement(
         context, MaterialPageRoute(builder: (context) => const LogInScreen()));
   }
   else if(  islogin== true && FirebaseAuth.instance.currentUser!.uid =='XkbioiW6D8RT3tQPIr0u68cKnaq2'){
     Navigator.pushReplacement(
         context, MaterialPageRoute(builder: (context) => const Category(

     )));
   }
   else if(islogin== true){
     Navigator.pushReplacement(
         context, MaterialPageRoute(builder: (context) => const NavigationScreen()));
   }

 }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
