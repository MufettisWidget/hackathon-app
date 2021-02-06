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

  GoodNotice(this._city, this._district, this._neighborhood, this._street,
      this._streetNo);
  // Notice.withId(this._id, this._city);
  GoodNotice.withId(this._id);
  // factory Notice.fromJson(Map<String, dynamic> parsedJson) {

  // return new Notice(
  //     _id: parsedJson['city'],
  //     city: parsedJson['streets'],
  // );
//}

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
    if (value.length >= 1) {
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
    if (value.length >= 1) {
      _userId = value;
    }
  }

  set explation(String value) {
    if (value.length >= 1) {
      _explation = value;
    }
  }

  set photoName(String value) {
    if (value.length >= 1) {
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
    var map = Map<String, dynamic>();
    map["city"] = city;
    map["district"] = _district;
    map["street"] = _street;
    map["neighborhood"] = _neighborhood;

    if (_id != null) {
      map["id"] = _id;
    }

    return map;
  }

  GoodNotice.fromObject(dynamic o) {
    this._id = o["Id"];
    this.city = o["City"];
    this._district = o["District"];
    this._neighborhood = o["Neighborhood"];
    this._street = o["Street"];
    this._streetNo = o["StreetNo"];
    this._latitude = o["Latitude"];
    this._longitude = o["Longitude"];
    this._userId = o["UserId"];
    this._noticeStatus = o["NoticeStatus"];
    this._explation = o["Explation"];
    this._photoName = o["PhotoName"];
    this._reportedMunicipality = o["ReportedMunicipality"];
    this._twetterAddress = o["TwetterAddress"];
    this._noticeDate = o["NoticeDate"];
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
      // "id": user.id,
      "city": notice.city,
      "district": notice.district,
      "neighborhood": notice.neighborhood,
      "street": notice.street,
      "streetNo": notice.streetNo,
      "latitude": notice.latitude,
      "longitude": notice.longitude,
      "userId": notice.userId,
      "noticeStatus": notice._noticeStatus,
      "explation": notice.explation,
      "photoName": notice.photoName,
      "reportedMunicipality": notice.reportedMunicipality,
      "twetterAddress": notice.twetterAddress,
      "noticeDare": notice.noticeDate,
    };
  }
}

String postToJsonNotice(GoodNotice data) {
  final dyn = data.toJson(data);
  return json.encode(dyn);
}
