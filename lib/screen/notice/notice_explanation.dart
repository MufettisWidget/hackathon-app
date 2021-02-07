import 'dart:convert';

import 'package:MufettisWidgetApp/core/enum/singing_character.dart';
import 'package:MufettisWidgetApp/core/viewsmodel/notice_explanation_view_model.dart';
import 'package:MufettisWidgetApp/model/reponseModel/reponseNotice.dart';
import 'package:MufettisWidgetApp/ui/views/baseview.dart';
import 'package:MufettisWidgetApp/ui/views/custom_button.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../apis/city/city_api.dart';
import '../../apis/district/district_api.dart';
import '../../apis/notice/notice_api.dart';
import '../../core/shared_prefernces_api.dart';
import '../../mixin/validation_mixin.dart';
import '../../model/city.dart';
import '../../model/district.dart';
import '../../model/notice.dart';
import '../../shared/style/ui_helper.dart';
import 'success_share.dart';

class NoticeExplation extends StatefulWidget {
  final Notice notice;
  final String imagePath;

  NoticeExplation(this.notice, this.imagePath);

  State<StatefulWidget> createState() => NoticeExplationState(notice, imagePath);
}

class NoticeExplationState extends State with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  Notice notice;
  String imagePath;
  NoticeExplationState(this.notice, this.imagePath);
  TextEditingController controllerExplation;
  bool _isCreatingLink = false;
  String _linkMessage;
  SingingCharacter _character = SingingCharacter.districtNotice;
  NoticeExplanationdViewModel noticeExplanationdViewModel;
  @override
  void initState() {
    super.initState();
    controllerExplation = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance.init(context);
    return BaseView<NoticeExplanationdViewModel>(onModelReady: (model) {
      model.setContext(context);
      noticeExplanationdViewModel = model;
    }, builder: (context, model, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: UIHelper.PEAR_PRIMARY_COLOR,
          title: Text("Açıklama ekleyin"),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(25.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[explation(), selectDistrict(), _saveButton],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget explation() {
    return TextFormField(
      controller: controllerExplation,
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      maxLength: 200,
      validator: validateExplation,
      decoration: InputDecoration(labelText: "Açıklama", hintText: "Açıklama"),
      onSaved: (String value) {
        notice.explation = value;
      },
    );
  }

  Widget selectDistrict() {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('İlçe Belediyesine'),
          leading: Radio(
            value: SingingCharacter.districtNotice,
            groupValue: _character,
            onChanged: (SingingCharacter value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Büyükşehir Belediyesine'),
          leading: Radio(
            value: SingingCharacter.cityNotice,
            groupValue: _character,
            onChanged: (SingingCharacter value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget get _saveButton => Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: InkWell(
          borderRadius: loginButtonBorderStyle,
          onTap: () async {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  });
              noticeExplanationdViewModel.saveNotice(notice, _character, imagePath);
            }
          },
          child: Container(
            decoration: BoxDecoration(color: UIHelper.PEAR_PRIMARY_COLOR, borderRadius: loginButtonBorderStyle),
            height: UIHelper.dynamicHeight(200),
            width: UIHelper.dynamicWidth(1000),
            child: Center(
              child: Text(
                UIHelper.save,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: UIHelper.dynamicSp(40),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      );

  Future<bool> saveNoticessss(Notice notice) {
    setState(() {
      notice.noticeStatus = 1;
      notice.noticeDate = DateTime.now().toString();
      notice.userId = SharedManager().loginRequest.id;
      notice.photoName = imagePath.split('/').last.split('.').first;
      if (_character == SingingCharacter.cityNotice) {
        notice.reportedMunicipality = notice.city;
        notice.noticeStatus = 3;
        CityApiService.instance.getCity(notice.city).then((responseCity) {
          if (responseCity.statusCode == 200) {
            Map cityMap = jsonDecode(responseCity.body);
            notice.twetterAddress = "@" + City.fromJson(cityMap).twitterAddress;
            NoticeApiServices.instance.createNotice(notice).then((responseNotice) {
              setState(() {
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
                          userLogin.noticies = new List<Notice>();
                          userLogin.noticies = responseNotice.notices;
                          SharedManager().loginRequest = userLogin;
                        } else {
                          SharedManager().loginRequest = userLogin;
                        }
                      });

                      Navigator.push(context, MaterialPageRoute(builder: (_context) => SuccessShare(notice)));
                      return true;
                    }
                  });
                }
              });
            });
          }
        });
      }
      if (_character == SingingCharacter.districtNotice) {
        notice.reportedMunicipality = notice.district;
        notice.noticeStatus = 5;

        DistrictApiServices.instance.getDistrict(notice.city, notice.district).then((responseDistrict) {
          if (responseDistrict.statusCode == 200) {
            Map districtMap = jsonDecode(responseDistrict.body);
            notice.twetterAddress = "@" + District.fromJson(districtMap).twitterAddress;
            NoticeApiServices.instance.createNotice(notice).then((responseNotice) {
              Map noticeMap = jsonDecode(responseNotice.body);
              setState(() {
                notice.id = Notice.fromJson(noticeMap).id;
                if (responseNotice.statusCode == 201) {
                  NoticeApiServices.instance.createNoticePhoto(imagePath, notice.photoName).then((responseImage) {
                    setState(() async {
                      if (responseImage.statusCode == 200) {
                        var userLogin = SharedManager().loginRequest;

                        NoticeApiServices.instance.getmyNotice(userLogin.id).then((response) {
                          if (response.statusCode == 200) {
                            Map<String, dynamic> map = jsonDecode(response.body);
                            var responseNotice = ResponseNotice.fromJson(map);
                            userLogin.noticies = new List<Notice>();
                            userLogin.noticies = responseNotice.notices;
                            SharedManager().loginRequest = userLogin;
                          } else {
                            SharedManager().loginRequest = userLogin;
                          }
                        });

                        await Navigator.push(context, MaterialPageRoute(builder: (_context) => SuccessShare(notice)));
                        return true;
                      }
                    });
                  });
                }
              });
            });
          }
        });
      }
    });
  }
}
