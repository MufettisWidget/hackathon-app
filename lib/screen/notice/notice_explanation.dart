import 'dart:convert';

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
  @override
  void initState() {
    super.initState();
    controllerExplation = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: UIHelper.PEAR_PRIMARY_COLOR,
        title: Text("Yorumunuz.."),
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

  BorderRadius get _loginButtonBorderStyle => BorderRadius.only(
        bottomRight: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        topLeft: Radius.circular(20),
      );

  Widget get _saveButton => Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: InkWell(
          borderRadius: _loginButtonBorderStyle,
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
              saveNotice(notice);

              // saveNotice(notice);
            }
          },
          child: Container(
            decoration: BoxDecoration(color: UIHelper.PEAR_PRIMARY_COLOR, borderRadius: _loginButtonBorderStyle),
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

  Future<bool> saveNotice(Notice notice) {
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
                    setState(() async {
                      if (response.statusCode == 200) {
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

  Future<String> _createDynamicLink(bool short, String longUri, Notice notice) async {
    setState(() {
      //  _isCreatingLink = true;
    });

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      // uriPrefix: 'https://application.bildireyimbunu.com',
      uriPrefix: 'https://app.bildireyimbunu.com',
      link: Uri.parse('http://bildireyim.com/notice/' + notice.id),
      androidParameters: AndroidParameters(
        packageName: 'com.canozturk.bildireyim_bunu',
        minimumVersion: 0,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.ozturkcan.bildireyimBunu',
        minimumVersion: '1.0.0',
        appStoreId: '1526849365',
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink = await parameters.buildShortLink();
      url = shortLink.shortUrl;
    } else {
      url = await parameters.buildUrl();
    }
    // return url.origin.toString() + '/' + url.path.toString();
    setState(() {
      _linkMessage = url.toString();
      _isCreatingLink = false;
    });
  }

  // void _showDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: new Text("Teşekkürler :)"),
  //         content: new Text(
  //             "Bildiriniz kayıt edilmiştir. Kontrol edildikten sonra yayınlanacaktır."),
  //         actions: <Widget>[
  //           // usually buttons at the bottom of the dialog
  //           new FlatButton(
  //             child: new Text("Kapat"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               Navigator.of(context).pushNamed("/home");
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
}

// }
enum SingingCharacter { districtNotice, cityNotice }
