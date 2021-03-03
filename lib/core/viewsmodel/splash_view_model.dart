import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../apis/city/city_api.dart';
import '../../apis/district/district_api.dart';
import '../../apis/notice/notice_api.dart';
import '../../apis/token/token_api.dart';
import '../../model/district.dart';
import '../../model/jwt_token.dart';
import '../../model/notice.dart';
import '../../model/reponseModel/reponseNotice.dart';
import '../enum/paged_name.dart';
import '../shared_prefernces_api.dart';
import 'base_model.dart';

class SplashViewModel extends BaseModel {
  BuildContext _context;

  BuildContext get context => _context;

  List<Notice> noticeList;
  final SharedManager _sharedManager = SharedManager();

  SplashViewModel() {
    noticeList = <Notice>[];
  }

  Future login() async {
    if (_sharedManager.loginRequest != null) {
      var userLogin = SharedManager().loginRequest;

      await NoticeApiServices.instance.getmyNotice(SharedManager().loginRequest.id).then((response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> map = jsonDecode(response.body);
          var responseNotice = ResponseNotice.fromJson(map);
          userLogin.noticies = <Notice>[];
          userLogin.noticies = responseNotice.notices;
          SharedManager().loginRequest = userLogin;
        } else {}
      });
    } else {
      SharedManager().logOut();
    }

    Future<String> _getId() async {
      var deviceInfo = DeviceInfoPlugin();
      if (Platform.isIOS) {
        var iosDeviceInfo = await deviceInfo.iosInfo;
        return iosDeviceInfo.identifierForVendor;
      } else {
        var androidDeviceInfo = await deviceInfo.androidInfo;
        return androidDeviceInfo.androidId;
      }
    }

    String generateSignature(String dataIn, signature) {
      var encodedKey = utf8.encode(signature);
      var hmacSha256 = Hmac(sha256, encodedKey);
      var bytesDataIn = utf8.encode(dataIn);
      var digest = hmacSha256.convert(bytesDataIn);
      var singedValue = digest.toString();
      return singedValue;
    }

    var deviceId = await _getId();
    var cryptoToken = generateSignature(deviceId, 'BldrmBunu');

    await TokenApiServices.instance.getToken(deviceId, cryptoToken).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var returnToken = JwtToken.fromJson(map);

        SharedManager().tokenNotUser = returnToken.token;

        CityApiService.instance.getMostCity().then((response) {
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

        DistrictApiServices.instance.getMostDistrict().then((response) {
          if (response.statusCode == 200) {
            Map<String, dynamic> map = jsonDecode(response.body);
            var mostDistrict = District.fromJson(map);
            SharedManager().mostDistrictCount = mostDistrict.notifeCount.toString();
            SharedManager().mostDistrictName = mostDistrict.cityName.toString() + ' - ' + mostDistrict.districtName.toString();
          }
        });

        DistrictApiServices.instance.getMostDistrictSolutionRate().then((response) {
          if (response.statusCode == 200) {
            Map<String, dynamic> map = jsonDecode(response.body);
            var mostDistrictSolutionRate = District.fromJson(map);

            SharedManager().mostDistrictSolitionCount = '% ' + mostDistrictSolutionRate.solutionRate.toString();
            SharedManager().mostDistrictSolitionName =
                mostDistrictSolutionRate.cityName.toString() + ' - ' + mostDistrictSolutionRate.districtName.toString();
          }
        });

        NoticeApiServices.instance.getAllNoticeNoPage().then((response) {
          if (response.statusCode == 200) {
            Map<String, dynamic> map = jsonDecode(response.body);
            var responseNotice = ResponseNotice.fromJson(map);
            SharedManager().openNotice = responseNotice.notices;
            noticeList = responseNotice.notices;
          }
        });
      }
    });
  }

  void setContext(BuildContext context) {
    _context = context;

    login().whenComplete(() {
      Future.delayed(Duration(milliseconds: 3000), () {
        navigator.navigateToRemove(Pages.Home);
      });
    });
  }
}
