import 'dart:convert';

class Notice {
  String id;
  String city;
  String district;
  String street;
  String streetNo;
  String neighborhood;
  double latitude;
  double longitude;
  String userId;
  int noticeStatus;
  String explation;
  String photoName;
  String reportedMunicipality;
  String twetterAddress;
  String noticeDate;

  Notice(this.city, this.district, this.neighborhood, this.street, this.streetNo);

  Notice.withId(this.id);

  Notice.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    city = json['City'];
    district = json['District'];
    neighborhood = json['Neighborhood'];
    street = json['Street'];
    streetNo = json['StreetNo'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    userId = json['UserId'];
    noticeStatus = json['NoticeStatus'];
    explation = json['Explation'];
    photoName = json['PhotoName'];
    reportedMunicipality = json['ReportedMunicipality'];
    twetterAddress = json['TwetterAddress'];
    noticeDate = json['NoticeDate'];
  }

  Map<String, dynamic> toJson(Notice notice) {
    final data = <String, dynamic>{};
    data['Id'] = notice.id;
    data['City'] = notice.city;
    data['District'] = notice.district;
    data['Neighborhood'] = notice.neighborhood;
    data['Street'] = notice.street;
    data['StreetNo'] = notice.streetNo;
    data['Latitude'] = notice.latitude;
    data['Longitude'] = notice.longitude;
    data['UserId'] = notice.userId;
    data['NoticeStatus'] = notice.noticeStatus;
    data['Explation'] = notice.explation;
    data['PhotoName'] = notice.photoName;
    data['ReportedMunicipality'] = notice.reportedMunicipality;
    data['TwetterAddress'] = notice.twetterAddress;
    data['NoticeDate'] = notice.noticeDate;

    return data;
  }
}

String postToJsonNotice(Notice data) {
  final dyn = data.toJson(data);
  return json.encode(dyn);
}
