import 'dart:async';

import 'package:MufettisWidgetApp/ui/views/custom_button.dart';
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
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            body: Screenshot(
              controller: screenshotController,
              child: Container(
                color: UIHelper.PEAR_PRIMARY_COLOR,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    shareCustomButton("Linki Kopyala", onpLinkiKopyala),
                    shareCustomButton("Twitter'da Paylaş", onpTwitterPaylas),
                    shareCustomButton("Sms Gönder", onpSmsGonder),
                    shareCustomButton("Whatsapp'ta Paylaş", onpWhatssAppPaylas),
                    shareCustomButton("Telegram'dan Paylaş", onpShareTelegram),
                    shareCustomButton("Uygulama Seç", onpUygulamaSec),
                    SizedBox(
                      height: 10,
                    ),
                    customButton(UIHelper.mainPage, goToMainPage),
                    customButton(UIHelper.newNotice, _doNoticeViewModel.goNewNotice()),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void goToMainPage() {
    _doNoticeViewModel.goHome();
  }

  void onpShareTelegram() {
    SocialShare.shareTelegram(_linkMessage).then((data) {
      print(data);
    });
  }

  void onpWhatssAppPaylas() {
    SocialShare.shareWhatsapp(_linkMessage).then((data) {
      print(data);
    });
  }

  void onpUygulamaSec() {
    SocialShare.shareOptions(_linkMessage).then((data) {
      print(data);
    });
  }

  void onpSmsGonder() {
    SocialShare.shareSms("Bildireyim Bunu uygulamasindan bildirim paylaştım\n", url: _linkMessage, trailingText: "\n" + notice.explation)
        .then((data) {
      print(data);
    });
  }

  void onpTwitterPaylas() {
    {
      SocialShare.shareTwitter("BildireyimBunu uygulamasindan bildirim paylaştım " + notice.twetterAddress,
              url: _linkMessage, hashtags: ["bildireyimbunu", notice.reportedMunicipality], trailingText: "\n" + notice.explation)
          .then((data) {
        print(data);
      });
    }
  }

  void onpLinkiKopyala() {
    {
      SocialShare.copyToClipboard(
        _linkMessage,
      ).then((data) {
        print(data);
      });
    }
  }

  Container shareCustomButton(String text, onPressed) {
    return Container(
      height: 50.0,
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF8996E8), Color(0xFF4873FF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: loginButtonBorderStyle,
            ),
            child: Container(
              constraints: BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
              alignment: Alignment.center,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )),
      ),
    );
  }

  Widget customButton(String text, onPressed) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: InkWell(
        borderRadius: loginButtonBorderStyle,
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: loginButtonBorderStyle),
          height: UIHelper.dynamicHeight(200),
          width: UIHelper.dynamicWidth(1000),
          child: Center(
            child: Text(
              text,
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
  }

  @override
  void dispose() {
    super.dispose();
    notice = null;
  }
}
