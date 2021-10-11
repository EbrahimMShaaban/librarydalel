import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';

class InputSearch extends StatefulWidget {
  final String hint;
  final TextEditingController controller;

  InputSearch(
      {required this.hint,
        required this.controller});

  @override
  _InputSearchState createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12.5),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            fillColor: Colors.grey.shade100,
            filled: true,
            enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
            color: purple,
            width: 2.0,
            ),),
            hintText: widget.hint,
            hintStyle: hintStyle,
            prefixIcon: Icon(Icons.search,size: 25,color: clear_gray,),

          ),
        ),
      ),
    );
  }
}
