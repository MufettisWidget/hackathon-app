import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as places;
import 'package:location/location.dart';
import 'package:location_manager/location_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../apis/notice/notice_api.dart';
import '../../model/notice.dart';
import '../../model/reponseModel/reponseNotice.dart';
import '../../shared/style/ui_helper.dart';
import '../../shared/style/ui_padding_helper.dart';
import '../../ui/views/notice_detail_dialog_view.dart';
import '../core_helper.dart';
import '../enum/viewstate.dart';
import '../shared_prefernces_api.dart';
import 'base_model.dart';
import 'main_view_model.dart';

class CustomerNoticeMapViewModel extends BaseModel {
  final customerNoticeScaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_customerNoticeScaffoldKey');

  BuildContext _context;

  BuildContext get context => _context;

  Completer<GoogleMapController> controller = Completer();
  GoogleMapController mapController;

  Notice currentSelectNotice;
  List<Notice> noticeList = [];

  List<LatLng> polyLineList = [];
  String points;
  String km;

  Location location = Location();
  LatLng currentUserLocation;
  LocationManager newLocationManager;
  final Set<Polyline> polyline = {};

  Set<Marker> markerSet = {};
  Set<Marker> selectedMarker = {};

  String mapStyle;
  bool isBottomModalOpen = false;
  int currentPointPosition = 0;
  int currentMarketPosition = 0;
  int currentDistancePosition = 0;
  PolylinePoints polylinePoints;
  List<LatLng> polylineCoordinates = [];
  final Set<Polyline> _polylines = <Polyline>{};
  String infoViewText;

  SharedManager _sharedManager;

  final String USER_MARKER_ID = 'UserMarker';
  final String SEARCHED_MARKER_ID = 'SEARCHED_MARKER_ID';

  bool pointVisibility = false;

  final places.GoogleMapsPlaces _places = places.GoogleMapsPlaces(apiKey: CoreHelper.kGoogleApiKey);

  CustomerNoticeMapViewModel() {
    newLocationManager = LocationManager();
    _sharedManager = SharedManager();
    polylinePoints = PolylinePoints();

    rootBundle.loadString('assets/style/map_style.json').then((text) => {mapStyle = text});

    if (_sharedManager.homeLocation.lat != null) {
      currentUserLocation = LatLng(_sharedManager.homeLocation.lat, _sharedManager.homeLocation.lng);
    }

    newLocationManager.getLocation(
      onLocationValue: (val) {
        print(DateTime.now());
        currentUserLocation = val;
        addMarkerUser();
        print(val.latitude);
      },
      interval: 10000,
      isLocationTrack: true,
      onRejectPermission: () {
        addMarkerUser();

        snackBarWarningMessage('Lütfen Lokasyon izni verin.');
      },
    );

    getAllNoticies(isFilter: true);
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  // ignore: always_declare_return_types
  getAllNoticiesFilter() async {
    await navigator.pop();
    await getAllNoticies(isFilter: true);
  }

  // ignore: always_declare_return_types
  getAllNoticies({bool isFilter, bool isFilterReset}) async {
    setState(ViewState.Busy);
    if (SharedManager().openNotice != null) {
      noticeList = SharedManager().openNotice;
      addNoticeMarkers(true);
    } else {
      await NoticeApiServices.instance.getAllNoticeNoPage().then((response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> map = jsonDecode(response.body);
          var responseNotice = ResponseNotice.fromJson(map);
          noticeList = responseNotice.notices;
          addNoticeMarkers(isFilter);
        }
      });
    }
    setState(ViewState.Idle);
  }

  // ignore: always_declare_return_types
  addMarkerUser() async {
    try {
      markerSet.remove(markerSet.firstWhere((Marker marker) => marker.markerId.value == USER_MARKER_ID));
    } catch (e) {
      print('Marker Yok');
    }
    var m = Marker(
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(
              devicePixelRatio: 4,
            ),
            'assets/images/user_image.png'),
        markerId: MarkerId(USER_MARKER_ID),
        onTap: () {},
        position: LatLng(currentUserLocation.latitude, currentUserLocation.longitude));

    markerSet.add(m);
    notifyListeners();
  }

  // ignore: always_declare_return_types
  addNoticeMarkers(bool isFiltered) async {
    var filteredList = <LatLng>[];

    setState(ViewState.Busy);
    // ignore: prefer_collection_literals
    markerSet = Set();
    await addMarkerUser();
    for (var i = 0; i < noticeList.length; i++) {
      var resultMarker = Marker(
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(
              devicePixelRatio: 4,
            ),
            'assets/images/destination_map_marker.png'),
        markerId: MarkerId(noticeList[i].id),
        onTap: () {
          showModal(i);
        },
        position: LatLng(noticeList[i].latitude, noticeList[i].longitude),
      );

      markerSet.add(resultMarker);
      filteredList.add(LatLng(noticeList[i].latitude, noticeList[i].longitude));
    }

    if (isFiltered) {
      if (filteredList.length == 1) {
        try {
          Future.delayed(Duration(milliseconds: 300), () {
            if (mapController != null) {
              mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                target: LatLng(filteredList[0].latitude, filteredList[0].longitude),
                zoom: 12,
              )));
            }
          });
          // ignore: empty_catches
        } catch (e) {}
      } else {
        var bound = CoreHelper.boundsFromLatLngList(filteredList);
        if (mapController != null) {
          await mapController.animateCamera(CameraUpdate.newLatLngBounds(bound, 100));
        }
      }
    }

    setState(ViewState.Idle);
    notifyListeners();
  }

  Future openLeftDrawer() async => MainViewModel.openLeftMenu();

  void drawPolyLine() async {
    var result = await polylinePoints.getRouteBetweenCoordinates('AIzaSyALnT7pxhQRDuQ3X5RdHEFfUbGtr4w7VL8', currentUserLocation.latitude,
        currentUserLocation.longitude, currentSelectNotice.latitude, currentSelectNotice.longitude);

    if (result.isNotEmpty) {
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      _polylines.add(Polyline(width: 2, polylineId: PolylineId('poly'), color: Color.fromARGB(255, 40, 122, 198), points: polylineCoordinates));
    }

    polyline.add(Polyline(
      polylineId: PolylineId('station'),
      visible: true,
      width: 3,
      endCap: Cap.roundCap,
      startCap: Cap.roundCap,
      points: polylineCoordinates,
      color: Colors.grey,
    ));
  }

  // ignore: always_declare_return_types
  changePoint(int currentPoint) async {
    currentPointPosition = currentPoint;
    notifyListeners();
  }

  // ignore: always_declare_return_types
  changeDistance(int currentDistance) async {
    currentDistancePosition = currentDistance;
    notifyListeners();
  }

  // ignore: always_declare_return_types
  snackBarWarningMessage(String _message) async =>
      UIPaddingHelper.showSnackBar(key: customerNoticeScaffoldKey, child: Text(_message ?? '')).whenComplete(() {
        navigator.pop();
      });

  // ignore: always_declare_return_types
  onMapCreated(GoogleMapController _controller) async {
    mapController = _controller;
    await mapController.setMapStyle(mapStyle);
    controller.complete(_controller);

    focusMyLocation();
  }

  // ignore: always_declare_return_types
  focusMyLocation() async {
    try {
      Future.delayed(Duration(milliseconds: 300), () {
        if (mapController != null) {
          mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(currentUserLocation.latitude, currentUserLocation.longitude),
            zoom: 12,
          )));
        }
      });
      // ignore: empty_catches
    } catch (e) {}
  }

  // ignore: always_declare_return_types
  showModal(int index) async {
    setState(ViewState.Busy);

    currentSelectNotice = noticeList[index];

    var latLng_1 = LatLng(currentSelectNotice.latitude, currentSelectNotice.longitude);
    var latLng_2 = LatLng(currentUserLocation.latitude, currentUserLocation.longitude);
    var list = <LatLng>[];
    list.add(latLng_1);
    list.add(latLng_2);

    var bound = CoreHelper.boundsFromLatLngList(list);
    if (mapController != null) {
      await mapController.animateCamera(CameraUpdate.newLatLngBounds(bound, 100));
    }

    if (true) {
      if (customerNoticeScaffoldKey.currentState != null) {
        await showGeneralDialog(
          context: customerNoticeScaffoldKey.currentState.context,
          barrierColor: Colors.black12.withOpacity(0.2),
          barrierDismissible: false,
          transitionDuration: Duration(milliseconds: 100),
          pageBuilder: (_, __, ___) {
            return NoticeDetailDialogView(
              distanceMinute: currentSelectNotice.city ?? '',
              currentPointPosition: currentPointPosition,
              currentDistancePosition: currentDistancePosition,
              noticeDetail: currentSelectNotice,
              mapsRouteCallback: () {
                showModalBottom();
              },
              closeDialog: () {
                _closeModal();
              },
              mapsCallCallback: () {},
            );
          },
        );

        var resultMarker = Marker(
          icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(
                devicePixelRatio: 4,
              ),
              'assets/images/destination_map_marker.png'),
          infoWindow: InfoWindow(title: currentSelectNotice.street),
          markerId: MarkerId(currentSelectNotice.id),
          onTap: () {},
          position: LatLng(currentSelectNotice.latitude, currentSelectNotice.longitude),
        );

        selectedMarker.add(resultMarker);
        selectedMarker.add(markerSet.firstWhere((Marker marker) => marker.markerId == MarkerId(USER_MARKER_ID)));

        await newLocationManager.stopService();

        Future.delayed(Duration(milliseconds: 10), () {
          if (mapController != null) {
            mapController.showMarkerInfoWindow(resultMarker.markerId);
          }
        });

        changeModalOpenStatus(true);
        setState(ViewState.Idle);
      }
      // ignore: dead_code
    } else {
      snackBarWarningMessage('Bilgiler getirilemedi.');
    }
  }

  // ignore: always_declare_return_types
  launchMaps(String _url) async {
    if (currentUserLocation != null) {
      var url = _url;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print('Harita açılamadı');
      }
    }
  }

  void _closeModal() {
    focusMyLocation();
    navigator.pop();
    if (mapController != null) {
      mapController.hideMarkerInfoWindow(MarkerId(currentSelectNotice.id));
    }
    currentSelectNotice = null;
    polyline.clear();
    selectedMarker.clear();
    newLocationManager.resumeService();
    changeModalOpenStatus(false);
  }

  // ignore: always_declare_return_types
  changeModalOpenStatus(bool val) async {
    isBottomModalOpen = val;
    notifyListeners();
  }

  void menuItemsFilled() async {}

  Future showModalBottom() async {
    menuItemsFilled();
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.all(UIHelper.Space0),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(UIHelper.Space15),
                    topRight: Radius.circular(UIHelper.Space15),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    UIHelper.verticalSpaceSmall(),
                  ],
                )),
          ),
        );
      },
    );
  }

  Future<Null> displayPrediction(places.Prediction p) async {
    removeSearchPin();

    await getAllNoticies(isFilter: false, isFilterReset: true);

    if (p != null) {
      var detail = await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;

      var m = Marker(
          icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(
                devicePixelRatio: 4,
              ),
              'assets/images/ic_search_pin.png'),
          markerId: MarkerId(SEARCHED_MARKER_ID),
          onTap: () {},
          position: LatLng(lat, lng));

      markerSet.add(m);
      notifyListeners();
      try {
        Future.delayed(Duration(milliseconds: 300), () {
          mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(lat, lng),
            zoom: 11,
          )));
        });
        // ignore: empty_catches
      } catch (e) {}
    }
  }

  // ignore: always_declare_return_types
  removeSearchPin() async {
    try {
      markerSet.remove(markerSet.firstWhere((Marker marker) => marker.markerId.value == SEARCHED_MARKER_ID));
    } catch (e) {
      print('Marker Yok');
    }
  }

  @override
  void dispose() {
    newLocationManager.stopService();
    newLocationManager = null;
    super.dispose();
  }
}
