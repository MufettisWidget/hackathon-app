import '../notice.dart';

class ResponseNotice {
  int pageNumber;
  int pageSize;
  int totalPages;
  int totalRecords;
  List<Notice> notices;

  ResponseNotice({this.notices, this.pageNumber, this.pageSize, this.totalPages, this.totalRecords});

  factory ResponseNotice.fromJson(Map<String, dynamic> json) {
    Iterable list = json['Data'];
    print(list.runtimeType);
    List<Notice> _notices = list.map((i) => Notice.fromJson(i)).toList();

    return ResponseNotice(
      notices: _notices,
      pageNumber: json['PageNumber'],
      pageSize: json['PageSize'],
      totalPages: json['TotalPages'],
      totalRecords: json['TotalRecords'],
    );
  }
}
