// ignore_for_file: use_key_in_widget_constructors, prefer_typing_uninitialized_variables, must_be_immutable
import 'package:flutter/material.dart';
class InputText extends StatelessWidget {
  final   text;
  final  textDescribtion;
  TextStyle stl;
   InputText({
    required this.text,
    required this.textDescribtion,
    required this.stl
});
  @override
  Widget build(BuildContext context) {
    return Text('$text: $textDescribtion',style: stl,);
  }
}
