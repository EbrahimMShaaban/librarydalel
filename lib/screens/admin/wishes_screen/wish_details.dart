import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/book_details/input_text.dart';

class WishesDetails extends StatefulWidget {
  WishesDetails(
      {required this.image,
      required this.name,
      required this.comment,
      Key? key})
      : super(key: key);
  String? name, comment, image;

  @override
  _WishesDetailsState createState() => _WishesDetailsState();
}

class _WishesDetailsState extends State<WishesDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الامنية'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: white,
        titleTextStyle: labelStyle,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: gray,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            height: sizeFromHeight(context, 3),
            width: sizeFromWidth(context, 1.2),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      widget.image!),
                  fit: BoxFit.cover,
                ),
                color: gray,
                borderRadius: BorderRadius.circular(23)),
          ),
          Container(
            width: sizeFromWidth(context, 1),
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: white,
              border: Border.all(color: purple),
              boxShadow: const [BoxShadow(color: purple, blurRadius: 3)],
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputText(
                        text: 'اسم المستخدم ',
                        textDescribtion: widget.name,
                        stl: labelStyle2),
                    Text(
                      widget.comment!,
                      style: hintStyle,
                    ),
                  ],
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}
