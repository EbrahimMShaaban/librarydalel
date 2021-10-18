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
/////////////////////////////////////////
////////////////////////////////////////
///////////////////////////////////////
//////////////////////////////////////

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';

class SearchScreen extends StatefulWidget {
  @override
  _PastTripsViewState createState() => _PastTripsViewState();
}

class _PastTripsViewState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  var searchresult;
  var allresult = FirebaseFirestore.instance.collection('books').get() ;
  getresult(){
   // for(var book in allresult){
   //
   // }
  }

  late Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];
  @override
  void initState(){
    super.initState();

    print(allresult);
    print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
  }
  // void initState() {
  //   super.initState();
  //   _searchController.addListener(_onSearchChanged);
  // }

  // @override
  // void dispose() {
  //   _searchController.removeListener(_onSearchChanged);
  //   _searchController.dispose();
  //   super.dispose();
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   resultsLoaded = getSearchBooks();
  // }

  // _onSearchChanged() {
  //   searchResultsList();
  // }
  //
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

  // searchBooks() async {
  //   var result = await FirebaseFirestore.instance
  //       .collection('books')
  //       .where('bookname', isEqualTo: _searchController)
  //       .get();
  //   print(result);
  // }

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
                  onChanged: (val){
                    searchresult=val ;

                  },
                  //controller: _searchController,
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.search)),
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



////////////////
////////////////
///////////////////////

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class SerachScrean extends StatefulWidget {
//   @override
//   _SerachViewDataState createState() => _SerachViewDataState();
// }
// List<Color> colur=new List();
//
// final fb = FirebaseDatabase.instance.reference().child("PostData");
// List  list=new List();
// class _SerachViewDataState extends State<SearchScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text("Listview Design"),
//
//       ),
//       body: Container(
//         child: _listNew(),
//       ),
//     );
//   }
//   @override
//   void initState() {
//     fb.once().then((DataSnapshot snap){
//       print(snap);
//       var data=snap.value;
//       print(data);
//       list.clear();
//       data.forEach((key,value) {
//         ModelProject model=new ModelProject(
//           topic: value['topic'],
//           language: value['language'],
//           image: value['image'],
//           key: key,
//         );
//         list.add(model);
//       });
//       for(int i=0;i<list.length;i++){
//         colur.add(Create());
//       }
//       setState(() {
//       });
//     });
//   }
// }
//
//
//
// Widget _listNew(){
//   return ListView.builder(
//       itemCount: list.length,
//       itemBuilder: (context,pos){
//         if(list[pos].language=="C"){
//           return CurvedListItem(
//             title: list[pos].topic,
//             language: list[pos].language,
//             image: "assets/c.jpg",
//             image2: list[pos].image,
//             color: Colors.black,
//             nextColor: Colors.black,
//           );
//
//         }else if(list[pos].language=="Android"){
//           return CurvedListItem(
//             title: list[pos].topic,
//             language: list[pos].language,
//             image: "assets/android.jpg",
//             image2: list[pos].image,
//             color: Colors.black,
//             nextColor: Colors.black,
//           );
//         }
//         else if(list[pos].language=="Python"){
//           return CurvedListItem(
//             title: list[pos].topic,
//             language: list[pos].language,
//             image: "assets/python.jpg",
//             image2: list[pos].image,
//             color: Colors.black,
//             nextColor: Colors.black,
//           );
//         }
//         else if(list[pos].language=="C++"){
//           return CurvedListItem(
//             title: list[pos].topic,
//             language: list[pos].language,
//             image: "assets/cplus.jpg",
//             image2: list[pos].image,
//             color: Colors.black,
//             nextColor: Colors.black,
//           );
//         }else{
//           return CurvedListItem(
//             title: list[pos].topic,
//             language: list[pos].language,
//             image: "assets/flutter.jpg",
//             image2: list[pos].image,
//             color: Colors.black,
//            nextColor: Colors.black,
//           );
//
//         }
//       }
//   );
// }
//
// // Color getColor(int number) {
// //   for(int i=0;i<list.length;i++){
// //     if(i==number){
// //       return colur[i];
// //     }
// //   }
// // }
//
// class CurvedListItem extends StatelessWidget {
//   const CurvedListItem({
//     required this.title,
//     required this.language,
//     required this.image,
//     required this.image2,
//     required this.color,
//     required this.nextColor,
//   });
//
//   final String image;
//   final String title;
//   final String image2;
//   final String language;
//   final Color color;
//   final Color nextColor;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: nextColor,
//       child: Container(
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: const BorderRadius.only(
//             bottomLeft: Radius.circular(80.0),
//           ),
//         ),
//         padding: const EdgeInsets.only(
//           left: 32,
//           top: 20,
//           bottom: 20,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               language,
//               style: TextStyle(color: Colors.white, fontSize: 12),
//             ),
//             const SizedBox(
//               height: 2,
//             ),
//             Text(
//               title,
//               style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 25.0,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'DancingScript'
//               ),
//             ),
//             Row(
//               children: <Widget>[
//                 Container(
//                   padding: const EdgeInsets.all(8.0),
//                   width: 100,
//                   child:  new Stack(
//                     children: <Widget>[
//                       Container(
//                         width: 50.0,
//                         height: 50.0,
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                               fit: BoxFit.fill,
//                               image: new NetworkImage(
//                                 image2,
//                               ),
//                             )
//                         ),
//                       ),
//                       new Positioned(
//                         left: 30,
//                         child: Container(
//                           width: 50.0,
//                           height: 50.0,
//                           decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               image: DecorationImage(
//                                 fit: BoxFit.fill,
//                                 image: new AssetImage(
//                                   image,
//                                 ),
//                               )
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: 2,
//                 ),
//                 Text(
//                   language+" programming",
//                   style: TextStyle(color: Colors.white, fontSize: 12),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }