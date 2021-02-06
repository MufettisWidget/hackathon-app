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
  String _linkMessage;
  String _testString = "Arkaşlarına paylaşıp daha çok insana ulaşmasını sağlayabilirsiniz";
  // String url =
  //     'http://doktoraktuel.com/ilan-detay/satilik-rontgen-cihazi/${notice.id}';

  @override
  void initState() {
    super.initState();
    _createDynamicLink(true, '', notice);
    // Future.delayed(Duration(seconds: 2));
    initPlatformState();
    _createDynamicLink(true, '', notice);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // try {
    //   platformVersion = await SocialSharePlugin.platformVersion;
    // } on PlatformException {
    //   platformVersion = 'Failed to get platform version.';
    // }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    //_isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return BaseView<SuccesShareViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        _doNoticeViewModel = model;
      },
      builder: (context, model, child) {
        return Scaffold(
          // appBar: AppBar(
          //   backgroundColor: UIHelper.PEAR_PRIMARY_COLOR,
          //   title: Text("Bildirimi Paylaş"),
          //   actions: <Widget>[],
          // ),
          body: Screenshot(
            controller: screenshotController,
            child: Container(
              color: UIHelper.PEAR_PRIMARY_COLOR,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Text(
                  //   'Running on: $_platformVersion\n',
                  //   textAlign: TextAlign.center,
                  // ),
                  // RaisedButton(
                  //   onPressed: () async {
                  //     // ignore: deprecated_member_use
                  //     File file = await ImagePicker.pickImage(
                  //         source: ImageSource.gallery);
                  //     SocialShare.shareInstagramStory(
                  //             file.path,
                  //             "#ffffff",
                  //             "#000000",
                  //             'http://bildireiyimbunu.com/notice/${notice.id}')
                  //         .then((data) {
                  //       print(data);
                  //     });
                  //   },
                  //   child: Text("Share On Instagram Story"),
                  // ),
                  // RaisedButton(
                  //   onPressed: () async {
                  //     await screenshotController.capture().then((image) async {
                  //       SocialShare.shareInstagramStorywithBackground(
                  //               image.path,
                  //               "#ffffff",
                  //               "#000000",
                  //               'http://bildireiyimbunu.com/notice/${notice.id}',
                  //               backgroundImagePath: image.path)
                  //           .then((data) {
                  //         print(data);
                  //       });
                  //     });
                  //   },
                  //   child: Text("Share On Instagram Story with background"),
                  // ),
                  // RaisedButton(
                  //   onPressed: () async {
                  //     await screenshotController.capture().then((image) async {
                  //       //facebook appId is mandatory for andorid or else share won't work
                  //       Platform.isAndroid
                  //           ? SocialShare.shareFacebookStory(
                  //                   image.path,
                  //                   "#ffffff",
                  //                   "#000000",
                  //                   'http://bildireiyimbunu.com/notice/${notice.id}',
                  //                   appId: "702032617044309")
                  //               .then((data) {
                  //               print(data);
                  //             })
                  //           : SocialShare.shareFacebookStory(
                  //                   image.path,
                  //                   "#ffffff",
                  //                   "#000000",
                  //                   'http://bildireiyimbunu.com/notice/${notice.id}')
                  //               .then((data) {
                  //               print(data);
                  //             });
                  //     });
                  //   },
                  //   child: Text("Share On Facebook Story"),
                  // ),
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
                              url: _linkMessage,
                              hashtags: [
                                "bildireyimbunu",
                                // notice.city,
                                // notice.district,
                                notice.reportedMunicipality
                              ],
                              trailingText: "\n" + notice.explation)
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

  BorderRadius get _loginButtonBorderStyle => BorderRadius.only(
        bottomRight: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        topLeft: Radius.circular(20),
      );

  Widget get _anasayfa => Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: InkWell(
          borderRadius: _loginButtonBorderStyle,
          onTap: () {
            _doNoticeViewModel.goHome();
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: _loginButtonBorderStyle),
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
          borderRadius: _loginButtonBorderStyle,
          onTap: () {
            _doNoticeViewModel.goNewNotice();
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: _loginButtonBorderStyle),
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

  @override
  void dispose() {
    super.dispose();
    notice = null;
  }
}
