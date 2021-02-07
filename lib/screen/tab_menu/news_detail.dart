import 'dart:async';
import 'dart:ui';

import 'package:MufettisWidgetApp/core/core_helper.dart';
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
                  Text(CoreHelper.parseDateData(news.newsDate),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ))
                ],
              ),
              SizedBox(height: 20.0),
              Row(children: <Widget>[
                Flexible(
                  child: new Container(
                    padding: new EdgeInsets.only(right: 13.0),
                    child: new Text(
                      news.detail,
                      style: new TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Roboto',
                        color: new Color(0xFF212121),
                      ),
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }


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
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0), children: [TextSpan(text: ": " + CoreHelper.parseDateData(news.newsDate))]),
          ),
        ),
      ],
    );
  }


  Widget image() {
    return Image(
      image: NetworkImage(baseUrl + 'UploadFile/' + news.photoName + '.jpg'),
    );
  }



}

