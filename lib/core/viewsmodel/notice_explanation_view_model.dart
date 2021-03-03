import 'dart:convert';

import '../../apis/city/city_api.dart';
import '../../apis/district/district_api.dart';
import '../../apis/notice/notice_api.dart';
import '../enum/singing_character.dart';
import '../enum/viewstate.dart';
import '../../model/city.dart';
import '../../model/district.dart';
import '../../model/notice.dart';
import '../../model/reponseModel/reponseNotice.dart';
import '../../screen/notice/success_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../shared_prefernces_api.dart';
import 'base_model.dart';

//Kullanıcının Bildirim eklemesini sayğalan model
class NoticeExplanationdViewModel extends BaseModel {
  final noticeExplanationScaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_noticeExplanationScaffoldKey');

  BuildContext _context;

  BuildContext get context => _context;

  // ignore: empty_constructor_bodies
  NoticeExplanationdViewModel() {}

  void setContext(BuildContext context) {
    context = context;
  }

  // ignore: missing_return
  Future<bool> saveNotice(Notice notice, SingingCharacter character, String imagePath) {
    notice.noticeStatus = 1;
    notice.noticeDate = DateTime.now().toString();
    notice.userId = SharedManager().loginRequest.id;
    notice.photoName = imagePath.split('/').last.split('.').first;
    if (character == SingingCharacter.cityNotice) {
      notice.reportedMunicipality = notice.city;
      notice.noticeStatus = 3;
      CityApiService.instance.getCity(notice.city).then((responseCity) {
        if (responseCity.statusCode == 200) {
          Map cityMap = jsonDecode(responseCity.body);
          notice.twetterAddress = '@' + City.fromJson(cityMap).twitterAddress;
          NoticeApiServices.instance.createNotice(notice).then((responseNotice) {
            if (responseNotice.statusCode == 201) {
              Map noticeMap = jsonDecode(responseNotice.body);
              notice.id = Notice.fromJson(noticeMap).id;
              NoticeApiServices.instance.createNoticePhoto(imagePath, notice.photoName).then((response) {
                if (response.statusCode == 200) {
                  var userLogin = SharedManager().loginRequest;

                  NoticeApiServices.instance.getmyNotice(userLogin.id).then((response) {
                    if (response.statusCode == 200) {
                      Map<String, dynamic> map = jsonDecode(response.body);
                      var responseNotice = ResponseNotice.fromJson(map);
                      userLogin.noticies = <Notice>[];
                      userLogin.noticies = responseNotice.notices;
                      SharedManager().loginRequest = userLogin;
                    } else {
                      SharedManager().loginRequest = userLogin;
                    }
                  });
                  Navigator.of(context)
                      .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SuccessShare(notice)), (Route<dynamic> route) => false);
                  // Navigator.push(context, MaterialPageRoute(builder: (_context) => SuccessShare(notice)));
                  return true;
                }
              });
            }
          });
        }
      });
    }
    if (character == SingingCharacter.districtNotice) {
      notice.reportedMunicipality = notice.district;
      notice.noticeStatus = 5;

      DistrictApiServices.instance.getDistrict(notice.city, notice.district).then((responseDistrict) {
        if (responseDistrict.statusCode == 200) {
          Map districtMap = jsonDecode(responseDistrict.body);
          notice.twetterAddress = '@' + District.fromJson(districtMap).twitterAddress;
          NoticeApiServices.instance.createNotice(notice).then((responseNotice) {
            Map noticeMap = jsonDecode(responseNotice.body);
            //setState(() {
            notice.id = Notice.fromJson(noticeMap).id;
            if (responseNotice.statusCode == 201) {
              NoticeApiServices.instance.createNoticePhoto(imagePath, notice.photoName).then((responseImage) {
                setState(ViewState.Busy);

                // setState(() async {
                if (responseImage.statusCode == 200) {
                  var userLogin = SharedManager().loginRequest;

                  NoticeApiServices.instance.getmyNotice(userLogin.id).then((response) {
                    if (response.statusCode == 200) {
                      setState(ViewState.Idle);
                      Map<String, dynamic> map = jsonDecode(response.body);
                      var responseNotice = ResponseNotice.fromJson(map);
                      userLogin.noticies = <Notice>[];
                      userLogin.noticies = responseNotice.notices;
                      SharedManager().loginRequest = userLogin;
                    } else {
                      setState(ViewState.Idle);
                      SharedManager().loginRequest = userLogin;
                    }
                  });

                  Navigator.push(context, MaterialPageRoute(builder: (_context) => SuccessShare(notice)));
                  return true;
                }
                //  });
              });
            }
            //  });
          });
        }
      });
    }
  }
}
