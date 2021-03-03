import 'dart:async';
import 'dart:ui';

import '../../core/core_helper.dart';
import '../../core/viewsmodel/my_notice_detail_view_model.dart';
import '../../ui/views/baseview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../main.dart';
import '../../mixin/validation_mixin.dart';
import '../../model/notice.dart';
import '../../shared/style/ui_helper.dart';

class MyNoticeDetail extends StatefulWidget {
  final Notice notice;

  MyNoticeDetail(this.notice);

  @override
  State<StatefulWidget> createState() => MyNoticeDetailState(notice);
}

class MyNoticeDetailState extends State with ValidationMixin {
  // ignore: unused_field
  MyNoticeDetailViewModel _myNoticeDetailViewModel;
  final formKey = GlobalKey<FormState>();
  Notice notice;
  String imagePath;
  MyNoticeDetailState(this.notice);
  TextEditingController controllerExplation;
  CameraPosition _currentPosition;
  final Set<Marker> _markers = {};
  final Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor pinLocationIcon;
  @override
  void initState() {
    super.initState();
    controllerExplation = TextEditingController(text: '');
    _currentPosition = CameraPosition(
      target: LatLng(notice.latitude, notice.longitude),
      zoom: 17.4746,
    );

    setCustomMapPin();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 5.5), 'assets/images/destination_map_marker.png');
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<MyNoticeDetailViewModel>(onModelReady: (model) {
      model.setContext(context);
      _myNoticeDetailViewModel = model;
    }, builder: (context, model, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: UIHelper.PEAR_PRIMARY_COLOR,
          title: Text('Bildirim Detayı'),
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
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget createRow(String header, String detail) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: RichText(
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold), children: [TextSpan(text: header)]),
          ),
        ),
        Expanded(
          flex: 7,
          child: RichText(
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0), children: [TextSpan(text: ': ' + detail)]),
          ),
        ),
      ],
    );
  }

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

  Widget reportedMunicipality() {
    return createRow('Belediye', notice.reportedMunicipality);
  }

  Widget city() {
    return createRow('Şehir', notice.city);
  }

  Widget district() {
    return createRow('İlçe', notice.district);
  }

  Widget street() {
    return createRow('Sokak', notice.street);
  }

  Widget streetNo() {
    return createRow('No', notice.streetNo);
  }

  Widget status() {
    return createRow('Durumu', CoreHelper.getStatus(notice.noticeStatus));
  }

  Widget createDate() {
    return createRow('Tarih', CoreHelper.parseDateData(notice.noticeDate));
  }

  Widget image() {
    return Image(
      image: NetworkImage(baseUrl + 'UploadFile/' + notice.photoName + '.jpg'),
    );
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
}
