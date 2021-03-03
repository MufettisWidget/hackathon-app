import 'dart:async';
import 'dart:ui';

import '../../core/core_helper.dart';
import '../../core/viewsmodel/notice_detail_view_model.dart';
import '../../ui/views/baseview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../main.dart';
import '../../model/notice.dart';
import '../../shared/style/ui_helper.dart';

class NoticeDetail extends StatefulWidget {
  final Notice notice;

  NoticeDetail(this.notice);

  @override
  State<StatefulWidget> createState() => NoticeDetailState(notice);
}

class NoticeDetailState extends State {
  // ignore: unused_field
  NoticeDetailViewModel _noticeDetailViewModel;
  final formKey = GlobalKey<FormState>();
  Notice notice;
  NoticeDetailState(this.notice);
  TextEditingController controllerExplation;
  CameraPosition _currentPosition;
  final Set<Marker> _markers = {};
  final Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor pinLocationIcon;
  @override
  void initState() {
    super.initState();

    if (notice.latitude != null) {
      controllerExplation = TextEditingController(text: '');
      _currentPosition = CameraPosition(
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
    return BaseView<NoticeDetailViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        _noticeDetailViewModel = model;
      },
      builder: (context, model, child) {
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
      },
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
                TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold), children: [TextSpan(text: 'Belediye')]),
          ),
        ),
        Expanded(
          flex: 7,
          child: RichText(
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0), children: [TextSpan(text: ': ' + notice.reportedMunicipality)]),
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
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold), children: [TextSpan(text: 'Şehir')]),
          ),
        ),
        Expanded(
          flex: 7,
          child: RichText(
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0), children: [TextSpan(text: ': ' + notice.city)]),
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
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold), children: [TextSpan(text: 'İlçe')]),
          ),
        ),
        Expanded(
          flex: 7,
          child: RichText(
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0), children: [TextSpan(text: ': ' + notice.district)]),
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
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold), children: [TextSpan(text: 'Sokak')]),
          ),
        ),
        Expanded(
          flex: 7,
          child: RichText(
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0), children: [TextSpan(text: ': ' + notice.street)]),
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
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold), children: [TextSpan(text: 'No')]),
          ),
        ),
        Expanded(
          flex: 7,
          child: RichText(
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0), children: [TextSpan(text: ': ' + notice.streetNo)]),
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
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold), children: [TextSpan(text: 'Durumu')]),
          ),
        ),
        Expanded(
          flex: 7,
          child: RichText(
            text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold),
                children: [TextSpan(text: ': ' + CoreHelper.getStatus(notice.noticeStatus))]),
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
            text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold), children: [TextSpan(text: 'Tarih')]),
          ),
        ),
        Expanded(
          flex: 7,
          child: RichText(
            text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 12.0),
                children: [TextSpan(text: ': ' + CoreHelper.parseDateData(notice.noticeDate))]),
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
