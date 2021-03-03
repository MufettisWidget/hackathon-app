import 'dart:convert';

class GoodNotice {
  String _id;
  String _city;
  String _district;
  String _street;
  String _streetNo;
  String _neighborhood;
  double _latitude;
  double _longitude;
  String _userId;
  int _noticeStatus;
  String _explation;
  String _photoName;
  String _reportedMunicipality;
  String _twetterAddress;
  String _noticeDate;

  GoodNotice(_city, _district, _neighborhood, _street, _streetNo);

  GoodNotice.withId(_id);

  String get id => _id;
  String get city => _city;
  String get district => _district;
  String get neighborhood => _neighborhood;
  String get street => _street;
  String get streetNo => _streetNo;
  double get latitude => _latitude;
  double get longitude => _longitude;
  String get userId => _userId;
  int get noticeStatus => _noticeStatus;
  String get explation => _explation;
  String get photoName => _photoName;
  String get reportedMunicipality => _reportedMunicipality;
  String get twetterAddress => _twetterAddress;
  String get noticeDate => _noticeDate;
  set id(String value) {
    if (value.length >= 2) {
      _id = value;
    }
  }

  set city(String value) {
    if (value.length >= 2) {
      _city = value;
    }
  }

  set district(String value) {
    if (value.length >= 2) {
      _district = value;
    }
  }

  set street(String value) {
    if (value.length >= 2) {
      _street = value;
    }
  }

  set neighborhood(String value) {
    if (value.length >= 2) {
      _neighborhood = value;
    }
  }

  set streetNo(String value) {
    if (value.isNotEmpty) {
      _streetNo = value;
    }
  }

  set latitude(double value) {
    if (value >= 0) {
      _latitude = value;
    }
  }

  set longitude(double value) {
    if (value >= 0) {
      _longitude = value;
    }
  }

  set userId(String value) {
    if (value.isNotEmpty) {
      _userId = value;
    }
  }

  set explation(String value) {
    if (value.isNotEmpty) {
      _explation = value;
    }
  }

  set photoName(String value) {
    if (value.isNotEmpty) {
      _photoName = value;
    }
  }

  set noticeStatus(int value) {
    if (value >= 1) {
      _noticeStatus = value;
    }
  }

  set reportedMunicipality(String value) {
    if (value.length >= 2) {
      _reportedMunicipality = value;
    }
  }

  set twetterAddress(String value) {
    if (value.length >= 2) {
      _twetterAddress = value;
    }
  }

  set noticeDate(String value) {
    _noticeDate = value;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['city'] = city;
    map['district'] = _district;
    map['street'] = _street;
    map['neighborhood'] = _neighborhood;

    if (_id != null) {
      map['id'] = _id;
    }

    return map;
  }

  GoodNotice.fromObject(dynamic o) {
    _id = o['Id'];
    city = o['City'];
    _district = o['District'];
    _neighborhood = o['Neighborhood'];
    _street = o['Street'];
    _streetNo = o['StreetNo'];
    _latitude = o['Latitude'];
    _longitude = o['Longitude'];
    _userId = o['UserId'];
    _noticeStatus = o['NoticeStatus'];
    _explation = o['Explation'];
    _photoName = o['PhotoName'];
    _reportedMunicipality = o['ReportedMunicipality'];
    _twetterAddress = o['TwetterAddress'];
    _noticeDate = o['NoticeDate'];
  }

  GoodNotice.fromJson(Map<String, dynamic> json) {
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

  Map toJson(GoodNotice notice) {
    return {
      'city': notice.city,
      'district': notice.district,
      'neighborhood': notice.neighborhood,
      'street': notice.street,
      'streetNo': notice.streetNo,
      'latitude': notice.latitude,
      'longitude': notice.longitude,
      'userId': notice.userId,
      'noticeStatus': notice._noticeStatus,
      'explation': notice.explation,
      'photoName': notice.photoName,
      'reportedMunicipality': notice.reportedMunicipality,
      'twetterAddress': notice.twetterAddress,
      'noticeDare': notice.noticeDate,
    };
  }
}

String postToJsonNotice(GoodNotice data) {
  final dyn = data.toJson(data);
  return json.encode(dyn);
}
