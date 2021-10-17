// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'input_search.dart';

class SearchScreen extends StatefulWidget {
   final TextEditingController searchController = TextEditingController();

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        InputSearch(hint: 'الفئة التي تريد البحث عنها', controller: widget.searchController)
      ],
    );
  }
}
