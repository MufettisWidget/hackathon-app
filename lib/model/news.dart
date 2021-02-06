import 'dart:convert';

class News {
  String id;
  String title;
  String detail;
  int noticeStatus;
  String newsMunicipality;
  String photoName;
  String newsDate;

  News();
  News.withId(this.id, this.title);

  News.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['Title'];
    detail = json['Detail'];
    noticeStatus = json['NewsStatus'];
    photoName = json['PhotoName'];
    newsMunicipality = json['NewsMunicipality'];
    newsDate = json['NoticeDate'];
  }

  Map<String, dynamic> toJson(News news) {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["Id"] = news.id;
    data["Detail"] = news.detail;
    data["Title"] = news.title;
    data["NewsStatus"] = news.noticeStatus;
    data["PhotoName"] = news.photoName;
    data["NewsMunicipality"] = news.newsMunicipality;
    data["NoticeDate"] = news.newsDate;
    return data;
  }
}

String postToJsonNotice(News data) {
  final dyn = data.toJson(data);
  return json.encode(dyn);
}
