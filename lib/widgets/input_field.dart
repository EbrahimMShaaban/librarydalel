// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';

class InputField extends StatefulWidget {
  final String hint;
  final String label;
  final bool scure;
  final Function onSaved;
  final Function validator;

  const InputField({
    required this.hint,
    required this.label,
    required this.scure,
    required this.onSaved,
    required this.validator,
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12.5),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
           onSaved: (value)=>widget.onSaved(),
           validator: widget.validator(),
          obscureText: widget.scure,
          decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: purple,width: 2.5),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide:  BorderSide(color: purple,width: 2.5),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: widget.label,
            hintText: widget.hint,
            labelStyle: labelStyle,
            hintStyle: hintStyle,
          ),
        ),
      ),
    );
  }
}
