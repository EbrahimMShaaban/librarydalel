// // ignore_for_file: use_key_in_widget_constructors
//
// import 'package:flutter/material.dart';
//
// import 'input_search.dart';
//
// class SearchScreen extends StatefulWidget {
//    final TextEditingController searchController = TextEditingController();
//
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         InputSearch(hint: 'الفئة التي تريد البحث عنها', controller: widget.searchController)
//       ],
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';

class SearchScreen extends StatefulWidget {
  @override
  _PastTripsViewState createState() => _PastTripsViewState();
}

class _PastTripsViewState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();

  // late Future resultsLoaded;
  // List _allResults = [];
  // List _resultsList = [];
  @override
  void initState(){
    super.initState();
    searchBooks();
  }
  // // void initState() {
  // //   super.initState();
  // //   _searchController.addListener(_onSearchChanged);
  // // }
  //
  // @override
  // // void dispose() {
  // //   _searchController.removeListener(_onSearchChanged);
  // //   _searchController.dispose();
  // //   super.dispose();
  // // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   resultsLoaded = getSearchBooks();
  // }

  // _onSearchChanged() {
  //   searchResultsList();
  // }

  // searchResultsList() {
  //   var showResults = [];
  //
  //   if (_searchController.text != "") {
  //     for (var book in _allResults) {
  //        var title = FirebaseFirestore.instance.collection('books').doc('bookname').get();
  //
  //       if((_searchController.text)) {
  //         showResults.add(book);
  //       }
  //     }
  //   } else {
  //     showResults = List.from(_allResults);
  //   }
  //   setState(() {
  //     _resultsList = showResults;
  //   });
  // }

  // getSearchBooks() async {
  //
  //    var data = await FirebaseFirestore.instance
  //        .collection('books').doc().get();
  //    setState(() {
  //      _allResults = data.id as List;
  //    });
  //   searchResultsList();
  //   return "complete";
  // }

  searchBooks() async {
    var result = await FirebaseFirestore.instance
        .collection('books')
        .where('bookname', isEqualTo: _searchController)
        .get();
    print(result);
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: sizeFromHeight(context, 15),
              ),
              Text("الكتب", style: labelStyle),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, right: 30.0, bottom: 30.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return const ListTile(
                          title: Text(''),
                          subtitle: Text('text'),
                        );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
// buildTripCard(context, _resultsList[index]),
