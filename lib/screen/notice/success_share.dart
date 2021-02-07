import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';

import '../../core/viewsmodel/succes_share_view_model.dart';
import '../../model/notice.dart';
import '../../shared/style/ui_helper.dart';
import '../../ui/views/baseview.dart';

class SuccessShare extends StatefulWidget {
  final Notice notice;
  static const String routeName = "/successShare";

  SuccessShare(this.notice);

  @override
  State<StatefulWidget> createState() => SuccessShareState(notice);
}

class SuccessShareState extends State<SuccessShare> {
  SuccesShareViewModel _doNoticeViewModel;
  final formKey = GlobalKey<FormState>();
  Notice notice;
  SuccessShareState(this.notice);
  String _platformVersion = 'Unknown';
  bool _isCreatingLink = false;
  String _linkMessage = "https://google.com";
  String _testString = "Arkaşlarına paylaşıp daha çok insana ulaşmasını sağlayabilirsiniz";

  @override
  void initState() {
    super.initState();

    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return BaseView<SuccesShareViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        _doNoticeViewModel = model;
      },
      builder: (context, model, child) {
        return Scaffold(
          body: Screenshot(
            controller: screenshotController,
            child: Container(
              color: UIHelper.PEAR_PRIMARY_COLOR,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () async {
                      SocialShare.copyToClipboard(
                        _linkMessage,
                      ).then((data) {
                        print(data);
                      });
                    },
                    child: Text("Linki Kopyala"),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      SocialShare.shareTwitter("BildireyimBunu uygulamasindan bildirim paylaştım " + notice.twetterAddress,
                              url: _linkMessage, hashtags: ["bildireyimbunu", notice.reportedMunicipality], trailingText: "\n" + notice.explation)
                          .then((data) {
                        print(data);
                      });
                    },
                    child: Text("Twitter'da Paylaş"),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      SocialShare.shareSms("Bildireyim Bunu uygulamasindan bildirim paylaştım\n",
                              url: _linkMessage, trailingText: "\n" + notice.explation)
                          .then((data) {
                        print(data);
                      });
                    },
                    child: Text("Sms Gönder"),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      await screenshotController.capture().then((image) async {
                        SocialShare.shareOptions(_linkMessage).then((data) {
                          print(data);
                        });
                      });
                    },
                    child: Text("Paylaşım Ayarları"),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      SocialShare.shareWhatsapp(_linkMessage).then((data) {
                        print(data);
                      });
                    },
                    child: Text("Whatsapp'ta Paylaş"),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      SocialShare.shareTelegram(_linkMessage).then((data) {
                        print(data);
                      });
                    },
                    child: Text("Telegram'dan Paylaş"),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      SocialShare.checkInstalledAppsForShare().then((data) {
                        print(data.toString());
                      });
                    },
                    child: Text("Bütün Uygulamalarım"),
                  ),
                  _anasayfa,
                  _newNotice,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  BorderRadius get loginButtonBorderStyle => BorderRadius.only(
        bottomRight: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        topLeft: Radius.circular(20),
      );

  Widget get _anasayfa => Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: InkWell(
          borderRadius: loginButtonBorderStyle,
          onTap: () {
            _doNoticeViewModel.goHome();
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: loginButtonBorderStyle),
            height: UIHelper.dynamicHeight(200),
            width: UIHelper.dynamicWidth(1000),
            child: Center(
              child: Text(
                UIHelper.mainPage,
                style: TextStyle(
                  color: UIHelper.PEAR_PRIMARY_COLOR,
                  fontSize: UIHelper.dynamicSp(40),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      );

  Widget get _newNotice => Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: InkWell(
          borderRadius: loginButtonBorderStyle,
          onTap: () {
            _doNoticeViewModel.goNewNotice();
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: loginButtonBorderStyle),
            height: UIHelper.dynamicHeight(200),
            width: UIHelper.dynamicWidth(1000),
            child: Center(
              child: Text(
                UIHelper.newNotice,
                style: TextStyle(
                  color: UIHelper.PEAR_PRIMARY_COLOR,
                  fontSize: UIHelper.dynamicSp(40),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      );

  @override
  void dispose() {
    super.dispose();
    notice = null;
  }
}
