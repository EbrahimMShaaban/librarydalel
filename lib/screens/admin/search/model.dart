class SearchModel {
  String? authorname, bookname, columnnum, imageurl, rownum, type, userid, id;
  int? bookid;

  SearchModel({
    this.userid,
    this.imageurl,
    this.rownum,
    this.bookid,
    this.type,
    this.bookname,
    this.columnnum,
    this.authorname,
    this.id,
  });
}
