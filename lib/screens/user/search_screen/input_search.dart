import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';

class InputSearch extends StatefulWidget {
  final String hint;
  final TextEditingController controller;

  const InputSearch(
      {Key? key, required this.hint,
        required this.controller}) : super(key: key);

  @override
  _InputSearchState createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12.5),
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
            enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
            color: purple,
            width: 2.0,
            ),),
            hintText: widget.hint,
            hintStyle: hintStyle,
            prefixIcon: const Icon(Icons.search,size: 25,color: clearGray,),

          ),
        ),
      ),
    );
  }
}
