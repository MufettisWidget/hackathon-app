import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/lat_long.dart';
import '../model/news.dart';
import '../model/notice.dart';
import '../model/user.dart';
import 'enum/shared_data.dart';

class SharedManager {
  SharedManager._privateConstructor() {
    SharedPreferences.getInstance().then((prefs) {
      this.prefs = prefs;
    });
  }

  static final SharedManager _instance = SharedManager._privateConstructor();

  factory SharedManager() {
    if (_instance.prefs == null) SharedManager._privateConstructor();
    return _instance;
  }

  SharedPreferences prefs;

  Future initInstance() async {
    this.prefs = await SharedPreferences.getInstance();
  }

  logOut() {
    prefs.remove(ClientSharedEnum.loginRequestBb.toString());
    prefs.remove(ClientSharedEnum.notUserTokenBb.toString());

    prefs.remove(ClientSharedEnum.jwtToken.toString());
  }

  String get tokenNotUser => prefs.getString(ClientSharedEnum.notUserTokenBb.toString()) ?? null;
  set tokenNotUser(String token) {
    prefs.setString(ClientSharedEnum.notUserTokenBb.toString(), token);
  }

  String get jwtToken => prefs.getString(ClientSharedEnum.jwtToken.toString()) ?? null;
  set jwtToken(String jwtToken) {
    prefs.setString(ClientSharedEnum.jwtToken.toString(), jwtToken);
  }

  User get loginRequest {
    var userJson = _getFromDisk(ClientSharedEnum.loginRequestBb.toString());
    if (userJson == 'null' || userJson == null) {
      return null;
    }

    return User.fromJson(json.decode(userJson));
  }

  set loginRequest(User loginRequest) {
    saveStringToDisk(ClientSharedEnum.loginRequestBb.toString(), json.encode(loginRequest.toJson(loginRequest)));
  }

  String get mostCityCount => prefs.get(ClientSharedEnum.mostCityCount.toString()) ?? '0';

  set mostCityCount(String mostCityCount) {
    prefs.setString(ClientSharedEnum.mostCityCount.toString(), mostCityCount);
  }

  String get mostCityName => prefs.get(ClientSharedEnum.mostCityName.toString()) ?? '0';

  set mostCityName(String mostCityName) {
    prefs.setString(ClientSharedEnum.mostCityName.toString(), mostCityName);
  }

  String get mostCitySolitionCount => prefs.get(ClientSharedEnum.mostCitySolitionCount.toString()) ?? '0';

  set mostCitySolitionCount(String mostCitySolitionCount) {
    prefs.setString(ClientSharedEnum.mostCitySolitionCount.toString(), mostCitySolitionCount);
  }

  String get mostCitySolitionName => prefs.get(ClientSharedEnum.mostCitySolitionName.toString()) ?? '0';

  set mostCitySolitionName(String mostCitySolitionName) {
    prefs.setString(ClientSharedEnum.mostCitySolitionName.toString(), mostCitySolitionName);
  }

  String get mostDistrictCount => prefs.get(ClientSharedEnum.mostDistrictCount.toString()) ?? '0';

  set mostDistrictCount(String mostDistrictCount) {
    prefs.setString(ClientSharedEnum.mostDistrictCount.toString(), mostDistrictCount);
  }

  String get mostDistrictName => prefs.get(ClientSharedEnum.mostDistrictName.toString()) ?? '0';

  set mostDistrictName(String mostDistrictName) {
    prefs.setString(ClientSharedEnum.mostDistrictName.toString(), mostDistrictName);
  }

  String get mostDistrictSolitionCount => prefs.get(ClientSharedEnum.mostDistrictSolitionCount.toString()) ?? '0';

  set mostDistrictSolitionCount(String mostDistrictSolitionCount) {
    prefs.setString(ClientSharedEnum.mostDistrictSolitionCount.toString(), mostDistrictSolitionCount);
  }

  String get mostDistrictSolitionName => prefs.get(ClientSharedEnum.mostDistrictSolitionName.toString()) ?? '0';

  set mostDistrictSolitionName(String mostDistrictSolitionName) {
    prefs.setString(ClientSharedEnum.mostDistrictSolitionName.toString(), mostDistrictSolitionName);
  }

  List<Notice> get openNotice {
    var openNoticeJson = _getFromDisk(ClientSharedEnum.allNoticeBb.toString());
    if (openNoticeJson == null || openNoticeJson.toString().contains("null")) {
      return null;
    }
    Iterable l = json.decode(openNoticeJson);
    var cardList = l.map((model) => Notice.fromJson(model)).toList();
    return cardList;
  }

  set openNotice(List<Notice> notices) {
    saveStringToDisk(ClientSharedEnum.allNoticeBb.toString(), json.encode(notices.map((e) => e.toJson(e)).toList()));
  }

  List<News> get news {
    var news = _getFromDisk(ClientSharedEnum.newsBb.toString());
    if (news == null || news.toString().contains("null")) {
      return null;
    }
    Iterable l = json.decode(news);
    var newsList = l.map((model) => News.fromJson(model)).toList();
    return newsList;
  }

  set news(List<News> news) {
    saveStringToDisk(ClientSharedEnum.newsBb.toString(), json.encode(news.map((e) => e.toJson(e)).toList()));
  }

  HomeLocationModel get homeLocation {
    var homeLocation = _getFromDisk(ClientSharedEnum.homeLocationBb.toString());
    if (homeLocation == null) {
      return new HomeLocationModel(lat: 40.9801401, lng: 29.0735152);
    }

    return HomeLocationModel.fromJson(json.decode(homeLocation));
  }

  set homeLocation(HomeLocationModel homeLocation) {
    saveStringToDisk(ClientSharedEnum.homeLocationBb.toString(), json.encode(homeLocation.toJson()));
  }

  void saveStringToDisk(String key, String content) {
    print('(TRACE) LocalStorageService:_saveStringToDisk. key: $key value: $content');
    prefs.setString(key, content);
  }

  dynamic _getFromDisk(String key) {
    if (prefs != null) {
      var value = prefs.get(key);
      print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
      return value;
    } else {
      return null;
    }
  }
}
