import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
class InputText extends StatelessWidget {
  final  String text;
  final String textDescribtion;
  InputText({
    required this.text,
    required this.textDescribtion,
});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
      child: Text('$text:$textDescribtion',style: appbarStyle,),

    );
  }
}
