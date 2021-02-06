import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../apis/notice/notice_api.dart';
import '../../main.dart';
import '../../mixin/validation_mixin.dart';
import '../../model/notice.dart';
import '../../shared/style/ui_helper.dart';
import '../notice/success_share.dart';

class NoticeDetail extends StatefulWidget {
  final Notice notice;

  NoticeDetail(this.notice);

  State<StatefulWidget> createState() => NoticeDetailState(notice);
}

class NoticeDetailState extends State with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  Notice notice;
  String imagePath;
  NoticeDetailState(this.notice);
  TextEditingController controllerExplation;
  SingingCharacter _character = SingingCharacter.districtNotice;
  CameraPosition _currentPosition;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor pinLocationIcon;
  @override
  void initState() {
    super.initState();

    if (notice.latitude != null) {
      controllerExplation = TextEditingController(text: "");
      _currentPosition = new CameraPosition(
        target: LatLng(notice.latitude, notice.longitude),
        zoom: 17.4746,
      );

      setCustomMapPin();
    }
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/destination_map_marker.png');
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: UIHelper.PEAR_PRIMARY_COLOR,
        title: Text("Bildirim Detayı"),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(25.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 6,
                      child: detail(),
                    ),
                    Expanded(
                      flex: 4,
                      child: image(),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[Expanded(flex: 9, child: noticeexplatipn())],
                ),
                SizedBox(height: 40.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[Expanded(flex: 9, child: mapStreet())],
                ),
                SizedBox(height: 40.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[Expanded(flex: 9, child: _footerButtonRow(notice))],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _footerButtonRow(Notice notice) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[],
      );

  Widget detail() {
    return Column(
      children: <Widget>[
        reportedMunicipality(),
        SizedBox(height: 10),
        city(),
        SizedBox(height: 10),
        district(),
        SizedBox(height: 10),
        street(),
        SizedBox(height: 10),
        streetNo(),
        SizedBox(height: 10),
        status(),
        SizedBox(height: 10),
        createDate()
      ],
    );
  }

  Widget reportedMunicipality() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: RichText(
            text:
                TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold), children: [TextSpan(text: "Belediye")]),
          ),
        ),
        Expanded(
          flex: 7,
          child: RichText(
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0), children: [TextSpan(text: ": " + notice.reportedMunicipality)]),
          ),
        ),
      ],
    );
  }

  Widget city() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: RichText(
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold), children: [TextSpan(text: "Şehir")]),
          ),
        ),
        Expanded(
          flex: 7,
          child: RichText(
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0), children: [TextSpan(text: ": " + notice.city)]),
          ),
        ),
      ],
    );
  }

  Widget district() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: RichText(
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold), children: [TextSpan(text: "İlçe")]),
          ),
        ),
        Expanded(
          flex: 7,
          child: RichText(
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0), children: [TextSpan(text: ": " + notice.district)]),
          ),
        ),
      ],
    );
  }

  Widget street() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: RichText(
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold), children: [TextSpan(text: "Sokak")]),
          ),
        ),
        Expanded(
          flex: 7,
          child: RichText(
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0), children: [TextSpan(text: ": " + notice.street)]),
          ),
        ),
      ],
    );
  }

  Widget streetNo() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: RichText(
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold), children: [TextSpan(text: "No")]),
          ),
        ),
        Expanded(
          flex: 7,
          child: RichText(
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0), children: [TextSpan(text: ": " + notice.streetNo)]),
          ),
        ),
      ],
    );
  }

  Widget status() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: RichText(
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold), children: [TextSpan(text: "Durumu")]),
          ),
        ),
        Expanded(
          flex: 7,
          child: RichText(
            text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold),
                children: [TextSpan(text: ": " + getStatus(notice.noticeStatus))]),
          ),
        ),
      ],
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
            text:
                TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0), children: [TextSpan(text: ": " + parseDateData(notice.noticeDate))]),
          ),
        ),
      ],
    );
  }

  Widget noticeexplatipn() {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: RichText(
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0), children: [TextSpan(text: notice.explation)]),
          ),
        ),
      ],
    );
  }

  Color getColor(status) {
    if (status & (8) == 8) return Colors.red;
    if (status & (8) != 8) return CupertinoColors.inactiveGray;
  }

  String getStatus(int status) {
    if (status & 8 == 8)
      return "İl Belediyesine Atandı.";
    else if (status & 16 == 16)
      return "İlçe Belediyesine Atandı.";
    else if (status & 64 == 64)
      return "Belediye tarafından bildirim düzeltildi. Kontrol bekliyor.";
    else if (status & 128 == 128)
      return "Kullanıcı onayladı";
    else if (status & 256 == 256)
      return "Belediye tarafından Sorun giderildi. Editör Onayladı.";
    else if (status & 1 == 1) return "İşlem Bekliyor";
  }

  String parseDateData(String dateData) {
    DateFormat formater = new DateFormat('yyy-MM-dd hh:mm');
    return formater.format(DateTime.parse(dateData));
  }

  Widget image() {
    return Image(
      image: NetworkImage(baseUrl + 'UploadFile/' + notice.photoName + '.jpg'),
    );
  }

  void gotoSucces(Notice notice) {
    bool x = _showDialog("Bildirimi durumu 'DÜZELDİ' olarak güncellenecektir.Tekrar güncellenemez.");

    if (x) {
      NoticeApiServices.instance.updateNoticeSuccess(notice).then((response) {
        setState(() {
          if (response.statusCode == 204) {}
        });
      });
    }
  }

  Widget mapStreet() {
    return Column(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 250,
        child: GoogleMap(
          mapType: MapType.normal,
          markers: _markers,
          initialCameraPosition: _currentPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            setState(() {
              _markers.add(Marker(markerId: MarkerId('USER_MARKER'), position: LatLng(notice.latitude, notice.longitude), icon: pinLocationIcon));
            });
          },
        ),
      ),
    ]);
  }

  Widget submitButton() {
    return RaisedButton(
      child: Text("Bildirimi Kaydet"),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          saveNotice(notice);
        }
      },
    );
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

  void saveNotice(Notice notice) {
    notice.noticeStatus = 1;

    notice.photoName = imagePath.split('/').last.split('.').first;

    if (_character == SingingCharacter.cityNotice) {
      notice.reportedMunicipality = notice.city;
      notice.noticeStatus = 3;
    }
    if (_character == SingingCharacter.districtNotice) {
      notice.reportedMunicipality = notice.district;
      notice.noticeStatus = 5;
    }
    NoticeApiServices.instance.createNotice(notice).then((response) {
      setState(() {
        if (response.statusCode == 121) {
          NoticeApiServices.instance.createNoticePhoto(imagePath, notice.photoName).then((response) {
            setState(() async {
              if (response.statusCode == 120) {
                await Navigator.push(context, MaterialPageRoute(builder: (_context) => SuccessShare(notice)));
              }
            });
          });
        }
      });
    });
  }
}

enum SingingCharacter { districtNotice, cityNotice }
