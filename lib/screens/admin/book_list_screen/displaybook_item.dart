// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/admin/add_book_screen/deletebook.dart';
import 'package:librarydalel/screens/admin/add_book_screen/eidt_book.dart';
import 'package:librarydalel/screens/admin/book_details/view.dart';

class DisplaybookItem extends StatefulWidget {
  final bookName;
  final docsid;
  final authname, colnum, rownum, type, image, icon;

  const DisplaybookItem({
    Key? key,
    required this.bookName,
    required this.docsid,
    required this.icon,
    required this.type,
    required this.image,
    required this.rownum,
    required this.colnum,
    required this.authname,
  }) : super(key: key);

  @override
  State<DisplaybookItem> createState() => _DisplaybookItemState();
}

class _DisplaybookItemState extends State<DisplaybookItem> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookDetails(
                      bookname: widget.bookName,
                      icon: widget.icon,
                      type: widget.type,
                      image: widget.image,
                      rownum: widget.rownum,
                      colnum: widget.colnum,
                      authname: widget.authname,
                      id: widget.docsid)));
        },
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: white,
            boxShadow: const [BoxShadow(color: white, blurRadius: 6)],
            border: Border.all(color: purple, width: 1.5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Text(
                  "${widget.bookName.data()['bookname']}",
                  maxLines: 2,
                  style: GoogleFonts.tajawal(
                      textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: gray,
                  )),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: sizeFromWidth(context, 2),
                ),
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditBook(
                                  books: widget.bookName,
                                  docsid: widget.docsid,
                                )));
                  },
                  child: const Icon(Icons.edit)),
              SizedBox(
                width: sizeFromWidth(context, 25),
              ),
              InkWell(
                  onTap: () {
                    showDialogWarning(context,
                        text: 'هل أنت متأكد من حذف الكتاب؟', ontap: () async {
                      await FirebaseFirestore.instance
                          .collection('books')
                          .doc(widget.docsid)
                          .delete();
                      await FirebaseFirestore.instance
                          .collection('books')
                          .doc(widget.docsid)
                          .collection('comments')
                          .get()
                          .then((snapshot) {
                        for (DocumentSnapshot ds in snapshot.docs) {
                          ds.reference.delete();
                        }
                      });
                      await FirebaseStorage.instance
                          .refFromURL(widget.image.data()['imageurl'])
                          .delete();
                      Navigator.pop(context);
                      await AwesomeDialog(
                              context: context,
                              title: "هام",
                              body: const Text("تمت عملية الحذف بنجاح"),
                              dialogType: DialogType.SUCCES)
                          .show();
                    });
                  },
                  child: const Icon(Icons.delete))
            ],
          ),
        ),
      ),
    );
  }
}
