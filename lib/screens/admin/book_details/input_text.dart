// ignore_for_file: use_key_in_widget_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';

class InputText extends StatelessWidget {
  final   text;
  final  textDescribtion;
  const InputText({
    required this.text,
    required this.textDescribtion,
});
  @override
  Widget build(BuildContext context) {
    return  Text('$text:$textDescribtion',style: textstyles,);
  }
}
