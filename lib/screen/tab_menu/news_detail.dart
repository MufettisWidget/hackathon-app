import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../apis/notice/notice_api.dart';
import '../../main.dart';
import '../../mixin/validation_mixin.dart';
import '../../model/news.dart';
import '../../model/notice.dart';
import '../../shared/style/ui_helper.dart';

//String get baseUrl => "http://api.bildireyimbunu.com/";
//String get baseUrl => "http://192.168.1.60/BilireyimBunu.WebApi/";

class NewsDetail extends StatefulWidget {
  final News news;

  NewsDetail(this.news);

  State<StatefulWidget> createState() => NewsDetailState(news);
}

class NewsDetailState extends State with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  News news;
  String imagePath;
  NewsDetailState(this.news);
  TextEditingController controllerExplation;
  SingingCharacter _character = SingingCharacter.districtNotice;
  CameraPosition _currentPosition;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor pinLocationIcon;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: UIHelper.PEAR_PRIMARY_COLOR,
        title: Text("Haber  Detayı"),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(25.0),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(this.news.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ))
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(parseDateData(news.newsDate),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ))
                ],
              ),
              SizedBox(height: 20.0),
              Row(children: <Widget>[
                // Text("Hello"),
                Flexible(
                  child: new Container(
                    padding: new EdgeInsets.only(right: 13.0),
                    child: new Text(
                      news.detail,
                      // overflow: TextOverflow.ellipsis,
                      style: new TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Roboto',
                        color: new Color(0xFF212121),
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 40.0),

              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //     Expanded(
              //         flex: 9, // takes 30% of available width
              //         child: _footerButtonRow(notice))
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconLabelDelete(String text) => Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        spacing: 5,
        children: <Widget>[
          Icon(
            Icons.delete,
            color: CupertinoColors.inactiveGray,
          ),
          Text(text),
          SizedBox(
            width: 10,
          )
        ],
      );

  Widget _iconLabelSuccess(String text, int status) => Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        spacing: 5,
        children: <Widget>[
          Icon(
            Icons.favorite,
            color: getColor(status),
          ),
          Text(text),
          SizedBox(
            width: 10,
          )
        ],
      );

  // Widget _footerButtonRow(Notice notice) => Row(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: <Widget>[
  //         // _iconLabelButtonEdit(notice),
  //         _iconLabelButtonDelete(notice),
  //         _iconLabelButtonSuccess(notice)
  //         // _iconLabelButton,
  //         // _iconLabelButton,
  //       ],
  //     );

  Widget _iconLabelButtonDelete(Notice notice) => Visibility(
      child: InkWell(
        child: _iconLabelDelete("Sil"),
        onTap: () {
          // gotoDelete(notice);
        },
      ),
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: notice.noticeStatus & 1 == 1);

  Widget _iconLabelButtonSuccess(Notice notice) => InkWell(
        child: _iconLabelSuccess("", notice.noticeStatus),
        onTap: () {
          if (notice.noticeStatus & (8) != 8) {
            gotoSucces(notice);
          }
        },
      );

  Widget createDate() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: RichText(
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold), children: [TextSpan(text: "Tarih")]),
          ),
        ),
        Expanded(
          flex: 7,
          child: RichText(
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0), children: [TextSpan(text: ": " + parseDateData(news.newsDate))]),
          ),
        ),
      ],
    );
  }

  // ignore: missing_return
  Color getColor(status) {
    if (status & (8) == 8) return Colors.red; // kullanıcı düzeltti
    if (status & (8) != 8) return CupertinoColors.inactiveGray;
  }

  // ignore: missing_return
  String getStatus(int status) {
    if (status & 1 == 1) return "İşlem Bekliyor";
    if (status & 8 == 8) return "İl Belediyesine Atandı.";
    if (status & 16 == 16) return "İlçe Belediyesine Atandı.";
    if (status & 64 == 64) return "Belediye tarafından bildirim düzeltildi. Kontrol bekliyor.";
    if (status & 128 == 128) return "Kullanıcı tarafından onaylandı";
    if (status & 256 == 256) return "Belediye tarafından Sorun giderildi. Editör Onayladı.";
  }

  String parseDateData(String dateData) {
    DateFormat formater = new DateFormat('yyy-MM-dd hh:mm');
    return formater.format(DateTime.parse(dateData));
  }

  Widget image() {
    return Image(
      image: NetworkImage(baseUrl + 'UploadFile/' + news.photoName + '.jpg'),
    );
  }

  void gotoSucces(Notice notice) {
    bool x = _showDialog("Bildirimi durumu 'DÜZELDİ' olarak güncellenecektir.Tekrar güncellenemez.");

    if (x) {
      NoticeApiServices.instance.updateNoticeSuccess(notice).then((response) {
        setState(() {
          if (response.statusCode == 204) {
            // notices = (json.decode(response.body) as List)
            //     .map((i) => Notice.fromJson(i))
            //     .toList();
          }
        });
      });
    }
  }

  bool _showDialog(String txt) {
    bool returnValue = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Bildiri"),
          content: new Text(txt),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Onayla"),
              onPressed: () {
                Navigator.of(context).pop();
                returnValue = true;
              },
            ),
            new FlatButton(
              child: new Text("İptal"),
              onPressed: () {
                returnValue = false;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    return returnValue;
  }
}

enum SingingCharacter { districtNotice, cityNotice }
