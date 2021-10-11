import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
class EditButton extends StatefulWidget {
  final String image;
 final Function onTap;
 EditButton({
   required this.onTap,
   required this.image,
});
  @override
  _EditButtonState createState() => _EditButtonState();
}

class _EditButtonState extends State<EditButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> widget.onTap(),
      child: Container(
        height: 30,
        width: 60,
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: white, blurRadius: 6)],
          border: Border.all(color: purple, width: 1.5),
          borderRadius: BorderRadius.circular(5),
        ),
        child: ImageIcon(
          AssetImage(
            'assets/${widget.image}.png',
          ),
          size: 10,
          color: gray,
        ),
      ),
    );
  }
}
