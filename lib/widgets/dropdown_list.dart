// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
class TypeList extends StatefulWidget {
  const TypeList({Key? key}) : super(key: key);
  @override
  _TypeListState createState() => _TypeListState();
}
class _TypeListState extends State<TypeList> {
  late final dropdownValue ;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text('ادخل النوع ',style: labelStyle2,),
          DropdownButton<String>(
            hint: Text('برجاء ادخال النوع',style: hintStyle,),
            value: dropdownValue,
            elevation: 3,
            underline: Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color:purple,
            ),
            onChanged: (newValue) {
              setState(() {
                dropdownValue=newValue!;
              });
            },
            items: <String>['الروايات', 'الادب' ,'قدرات','لغات']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width-70, // for example
                  child: Text(value, textAlign: TextAlign.left),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}