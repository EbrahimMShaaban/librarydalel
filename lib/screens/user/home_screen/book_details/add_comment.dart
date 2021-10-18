import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/alert.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/widgets/button/flatbuton.dart';
// ignore_for_file: use_key_in_widget_constructors

class AddComment extends StatefulWidget {
  AddComment(this.id);
  String id;
  @override
  State<AddComment> createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  final GlobalKey <FormState> _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
@override
  initState(){
    print((FirebaseAuth.instance.currentUser)!.email);
    super.initState();
  }


  validate(context) async {
    var formdata = _formKey.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        showLoading(context);
        await FirebaseFirestore.instance.collection('books').doc(widget.id).collection('comments').add(
            {
              "comment": controller.text,
              "userid": (FirebaseAuth.instance.currentUser)!.uid,
              "date": "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
            });
        Navigator.pop(context);
        Navigator.pop(context);
      } catch (e) {
        return const Text('erooooor');
      }
    }
  }

  // getName() async {
  //   final user = FirebaseAuth.instance.currentUser!.displayName;
  //   print(user);
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   getName();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          title: Text('إضافة تعليق ', style: appbarStyle),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back), color: purple,),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    onSaved: (value) {
                      // controller = value;
                    },
                    controller: controller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'برجاء اضافة تعليق';
                      }
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: 15,
                    maxLength: 200,
                    enableSuggestions: true,
                    decoration: InputDecoration(
                      fillColor: white,
                      isDense: false,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: purple, width: 2.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: purple, width: 2.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'اكتب تعليقك',
                      labelStyle: labelStyle,
                      hintStyle: hintStyle,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: sizeFromHeight(context, 30),
              ),
              Buton('إرسال', onTap: () async {
                await validate(context);
                print(widget.id);
              })
            ],
          ),
        ),
      ),
    );
  }
}
