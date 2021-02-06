import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../apis/city/city_api.dart';
import '../../apis/district/district_api.dart';
import '../../apis/news/news_api.dart';
import '../../apis/notice/notice_api.dart';
import '../../apis/token/token_api.dart';
import '../../model/district.dart';
import '../../model/jwt_token.dart';
import '../../model/news.dart';
import '../../model/notice.dart';
import '../../model/reponseModel/reponseNotice.dart';
import '../enum/paged_name.dart';
import '../shared_prefernces_api.dart';
import 'base_model.dart';

class SplashViewModel extends BaseModel {
  BuildContext _context;

  BuildContext get context => _context;

  List<Notice> noticeList;
  SharedManager _sharedManager = new SharedManager();

  SplashViewModel() {
    noticeList = new List<Notice>();
    // _apiService = new ApiServices();
    // tokenRequestModel = new TokenRequestModel();
    // _homeRequestModel = new HomeRequestModel();
    // campaignRequestModel = new CampaignRequestModel();

    //  _sharedManager.isFirstOpenHomePage = true;
    // _sharedManager.removeNews();
    // _sharedManager.removeCities();
  }

  Future login() async {
    if (_sharedManager.loginRequest != null) {
      // AccountApiServices.loginUser(_sharedManager.loginRequest.mailAddress,
      //         _sharedManager.loginRequest.password)
      //     .then((response) {
      //   if (response.statusCode == 200) {
      //     Map userMap = jsonDecode(response.body);
      //     var userLogin = User.fromJson(userMap);
      //     SharedManager().jwtToken = userLogin.userToken;

      var userLogin = SharedManager().loginRequest;

      NoticeApiServices.instance.getmyNotice(SharedManager().loginRequest.id).then((response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> map = jsonDecode(response.body);
          var responseNotice = ResponseNotice.fromJson(map);
          userLogin.noticies = new List<Notice>();
          userLogin.noticies = responseNotice.notices;
          SharedManager().loginRequest = userLogin;
          // setState(ViewState.Idle);
          // navigator.navigateToRemove(Pages.Home);
        } else {
          // setState(ViewState.Idle);

          //SharedManager().loginRequest = userLogin;
        }
      });
      // }
      // });
    } else {
      SharedManager().logOut();
    }

    Future<String> _getId() async {
      var deviceInfo = DeviceInfoPlugin();
      if (Platform.isIOS) {
        var iosDeviceInfo = await deviceInfo.iosInfo;
        return iosDeviceInfo.identifierForVendor; // unique ID on iOS
      } else {
        var androidDeviceInfo = await deviceInfo.androidInfo;
        return androidDeviceInfo.androidId; // unique ID on Android
      }
    }

    String generateSignature(String dataIn, signature) {
      var encodedKey = utf8.encode(signature); // signature=encryption key
      var hmacSha256 = new Hmac(sha256, encodedKey); // HMAC-SHA256 with key
      var bytesDataIn = utf8.encode(dataIn); // encode the data to Unicode.
      var digest = hmacSha256.convert(bytesDataIn); // encrypt target data
      String singedValue = digest.toString();
      return singedValue;
    }

    String deviceId = await _getId();
    String cryptoToken = generateSignature(deviceId, "BldrmBunu");

    TokenApiServices.instance.getToken(deviceId, cryptoToken).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var returnToken = JwtToken.fromJson(map);

        SharedManager().tokenNotUser = returnToken.token;

//----ggetMostCity
        CityApiService.instance.ggetMostCity().then((response) {
          if (response.statusCode == 200) {
            Map<String, dynamic> map = jsonDecode(response.body);
            var mostDistrict = District.fromJson(map);

            SharedManager().mostCityCount = mostDistrict.notifeCount.toString();
            SharedManager().mostCityName = mostDistrict.cityName.toString();
          }
        });

        CityApiService.instance.getMostCitySolutionRate().then((response) {
          if (response.statusCode == 200) {
            Map<String, dynamic> map = jsonDecode(response.body);
            var mostCitySolutionRate = District.fromJson(map);
            SharedManager().mostCitySolitionCount = '% ' + mostCitySolutionRate.solutionRate.toString();
            SharedManager().mostCitySolitionName = mostCitySolutionRate.cityName.toString();
          }
        });

        DistrictApiServices.instance.ggetMostDistrict().then((response) {
          if (response.statusCode == 200) {
            Map<String, dynamic> map = jsonDecode(response.body);
            var mostDistrict = District.fromJson(map);
            SharedManager().mostDistrictCount = mostDistrict.notifeCount.toString();
            SharedManager().mostDistrictName = mostDistrict.cityName.toString() + " - " + mostDistrict.districtName.toString();
          }
        });

        DistrictApiServices.instance.getMostDistrictSolutionRate().then((response) {
          if (response.statusCode == 200) {
            Map<String, dynamic> map = jsonDecode(response.body);
            var mostDistrictSolutionRate = District.fromJson(map);

            SharedManager().mostDistrictSolitionCount = '% ' + mostDistrictSolutionRate.solutionRate.toString();
            SharedManager().mostDistrictSolitionName =
                mostDistrictSolutionRate.cityName.toString() + " - " + mostDistrictSolutionRate.districtName.toString();
          }
        });

//---allnotice

        NoticeApiServices.instance.getAllNoticeNoPage().then((response) {
          if (response.statusCode == 200) {
            Map<String, dynamic> map = jsonDecode(response.body);
            var responseNotice = ResponseNotice.fromJson(map);
            SharedManager().openNotice = responseNotice.notices;
            noticeList = responseNotice.notices;
          }
        });
        NewsApiServices.getAllNews().then((response) {
          if (response.statusCode == 200) {
            var news = (json.decode(response.body) as List).map((i) => News.fromJson(i)).toList();
            SharedManager().news = news;
          }
        });
      }
    });

    // }
  }

  @override
  void setContext(BuildContext context) {
    this._context = context;

    // _sharedManager.notificationCount = 11;

    login().whenComplete(() {
      Future.delayed(Duration(milliseconds: 3000), () {
        navigator.navigateToRemove(Pages.Home);
      });
    });
  }
}
