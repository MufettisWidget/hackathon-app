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
import 'package:map_launcher/map_launcher.dart' as mapLauncher;
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
import '../utils/poly_list.dart';
import 'base_model.dart';
import 'main_view_model.dart';

class CustomerNoticeMapViewModel extends BaseModel {
  final customerNoticeScaffoldKey = GlobalKey<ScaffoldState>(debugLabel: "_customerNoticeScaffoldKey");

  BuildContext _context;

  BuildContext get context => _context;

  Completer<GoogleMapController> controller = Completer();
  GoogleMapController mapController;

  Notice currentSelectStation;
  List<PolyList> polyList;
  List<Notice> noticeList = new List();

  List<LatLng> polyLineList = new List();
  String points;
  String km;

  Location location = Location();
  LatLng currentUserLocation;
  LocationManager newLocationManager;
  final Set<Polyline> polyline = {};

  Set<Marker> markerSet = Set();
  Set<Marker> selectedMarker = new Set();

  //Map<MarkerId, Marker> markerList =<MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS

  String mapStyle;
  bool isBottomModalOpen = false;
  int currentPointPosition = 0;
  int currentMarketPosition = 0;
  int currentDistancePosition = 0;
  PolylinePoints polylinePoints;
  List<LatLng> polylineCoordinates = [];
  Set<Polyline> _polylines = Set<Polyline>();
  String infoViewText;

  SharedManager _sharedManager;

  final String USER_MARKER_ID = "UserMarker";
  final String SEARCHED_MARKER_ID = "SEARCHED_MARKER_ID";

  bool pointVisibility = false;
  //List<BottomMenuItem> mapLauncherMenuItems;

  places.GoogleMapsPlaces _places = places.GoogleMapsPlaces(apiKey: CoreHelper.kGoogleApiKey);

  CustomerNoticeMapViewModel() {
    newLocationManager = new LocationManager();
    _sharedManager = new SharedManager();
    polylinePoints = new PolylinePoints();

    rootBundle.loadString("assets/style/map_style.json").then((text) => {mapStyle = text});

    if (_sharedManager.homeLocation != null) {
      currentUserLocation = new LatLng(_sharedManager.homeLocation.lat, _sharedManager.homeLocation.lng);
    }

    newLocationManager.getLocation(
      onLocationValue: (val) {
        print(new DateTime.now());
        currentUserLocation = val;
        addMarkerUser();
        print(val.latitude);
      },
      interval: 10000,
      isLocationTrack: true,
      onRejectPermission: () {
        addMarkerUser();

        snackBarWarningMessage('translate(context, LanguageConstants.of(context).warningLocationPermission)');
      },
    );

    getAllNoticies(isFilter: true);
    //getLocation();
  }

  @override
  void setContext(BuildContext context) {
    this._context = context;
  }

  getAllNoticiesFilter() async {
    navigator.pop();
    await getAllNoticies(isFilter: true);
  }

  getAllNoticies({bool isFilter, bool isFilterReset}) async {
    setState(ViewState.Busy);
    if (SharedManager().openNotice != null) {
      noticeList = SharedManager().openNotice;
      addStationMarkers(true);
    } else {
      NoticeApiServices.instance.getAllNoticeNoPage().then((response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> map = jsonDecode(response.body);
          var responseNotice = ResponseNotice.fromJson(map);
          noticeList = responseNotice.notices;
          addStationMarkers(isFilter);
        }
      });
    }
    setState(ViewState.Idle);
  }

  addMarkerUser() async {
    try {
      markerSet.remove(markerSet.firstWhere((Marker marker) => marker.markerId.value == USER_MARKER_ID));
    } catch (e) {
      print("Marker Yok");
    }
    Marker m = Marker(
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

  addStationMarkers(bool isFiltered) async {
    List<LatLng> filteredList = [];

    setState(ViewState.Busy);
    markerSet = new Set();
    await addMarkerUser();
    for (int i = 0; i < noticeList.length; i++) {
      Marker resultMarker = Marker(
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
        } catch (e) {}
      } else {
        LatLngBounds bound = CoreHelper.boundsFromLatLngList(filteredList);
        if (mapController != null) {
          mapController.animateCamera(CameraUpdate.newLatLngBounds(bound, 100));
        }
      }
    }

    /* if(stationList != null && stationList.length == 0){
      addMarkerUser();
    }*/
    setState(ViewState.Idle);
    notifyListeners();
  }

  openLeftDrawer() {
    MainViewModel.openLeftMenu();
  }

  void drawPolyLine() async {
    //  var polyList = PolyHelper.convertToLatLng(PolyHelper.decodePoly(points));

    List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates("AIzaSyALnT7pxhQRDuQ3X5RdHEFfUbGtr4w7VL8",
        currentUserLocation.latitude, currentUserLocation.longitude, currentSelectStation.latitude, currentSelectStation.longitude);

    if (result.isNotEmpty) {
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      _polylines.add(Polyline(
          width: 2, // set the width of the polylines
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates));
    }

    polyline.add(Polyline(
      polylineId: PolylineId("station"),
      visible: true,
      width: 3,
      endCap: Cap.roundCap,
      startCap: Cap.roundCap,
      points: polylineCoordinates,
      //polyLineList,
      color: Colors.grey,
    ));
  }

  changePoint(int currentPoint) {
    currentPointPosition = currentPoint;
    notifyListeners();
  }

  changeDistance(int currentDistance) {
    currentDistancePosition = currentDistance;
    notifyListeners();
  }

  snackBarWarningMessage(String _message) {
    UIPaddingHelper.showSnackBar(key: customerNoticeScaffoldKey, child: Text(_message ?? "")).whenComplete(() {
      navigator.pop();
    });
  }

  onMapCreated(GoogleMapController _controller) async {
    mapController = _controller;
    mapController.setMapStyle(mapStyle);
    controller.complete(_controller);

    focusMyLocation();
  }

  focusMyLocation() {
    try {
      Future.delayed(Duration(milliseconds: 300), () {
        if (mapController != null) {
          mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(currentUserLocation.latitude, currentUserLocation.longitude),
            zoom: 12,
          )));
        }
      });
    } catch (e) {}
  }

  showModal(int index) async {
    setState(ViewState.Busy);

    currentSelectStation = noticeList[index];

    // double distanceInMeters = await Geolocator().distanceBetween(
    //     currentUserLocation.latitude,
    //     currentUserLocation.longitude,
    //     currentSelectStation.latitude,
    //     currentSelectStation.longitude);

    //String aa = (distanceInMeters / 1000).toStringAsFixed(2);

    LatLng latLng_1 = LatLng(currentSelectStation.latitude, currentSelectStation.longitude);
    LatLng latLng_2 = LatLng(currentUserLocation.latitude, currentUserLocation.longitude);
    List<LatLng> list = [];
    list.add(latLng_1);
    list.add(latLng_2);

    LatLngBounds bound = CoreHelper.boundsFromLatLngList(list);
    if (mapController != null) {
      mapController.animateCamera(CameraUpdate.newLatLngBounds(bound, 100));
    }

    if (true) {
      if (customerNoticeScaffoldKey.currentState != null) {
        showGeneralDialog(
          context: customerNoticeScaffoldKey.currentState.context,
          barrierColor: Colors.black12.withOpacity(0.2),
          barrierDismissible: false,
          transitionDuration: Duration(milliseconds: 100),
          pageBuilder: (_, __, ___) {
            return NoticeDetailDialogView(
              distanceMinute: currentSelectStation.city ?? "",
              currentPointPosition: currentPointPosition,
              currentDistancePosition: currentDistancePosition,
              noticeDetail: currentSelectStation,
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

        Marker resultMarker = Marker(
          icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(
                devicePixelRatio: 4,
              ),
              'assets/images/destination_map_marker.png'),
          infoWindow: InfoWindow(title: currentSelectStation.street),
          markerId: MarkerId(currentSelectStation.id),
          onTap: () {},
          position: LatLng(currentSelectStation.latitude, currentSelectStation.longitude),
        );

        selectedMarker.add(resultMarker);
        selectedMarker.add(markerSet.firstWhere((Marker marker) => marker.markerId == MarkerId(USER_MARKER_ID)));

        newLocationManager.stopService();

        //drawPolyLine();
        Future.delayed(Duration(milliseconds: 10), () {
          if (mapController != null) {
            mapController.showMarkerInfoWindow(resultMarker.markerId);
          }
        });

        changeModalOpenStatus(true);
        setState(ViewState.Idle);
      }
    } else {
      snackBarWarningMessage('Bilgiler getirilemedi.');
    }
  }

  List<LatLng> getLatLng(List<PolyList> polyList) {
    polyLineList = new List();

    for (int i = 0; i < polyList.length; i++) {
      polyLineList.add(new LatLng(polyList[i].latitude, polyList[i].longitude));
    }

    return polyLineList;
  }

  launchMaps(String _url) async {
    if (currentUserLocation != null) {
      String url = _url;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print("Harita açılamadı");
      }
    }
  }

  void _closeModal() {
    focusMyLocation();
    navigator.pop();
    if (mapController != null) {
      mapController.hideMarkerInfoWindow(MarkerId(currentSelectStation.id));
    }
    currentSelectStation = null;
    polyline.clear();
    selectedMarker.clear();
    newLocationManager.resumeService();
    changeModalOpenStatus(false);
  }

  changeModalOpenStatus(bool val) {
    isBottomModalOpen = val;
    notifyListeners();
  }

  void menuItemsFilled() async {
    // mapLauncherMenuItems.clear();
    // mapLauncherMenuItems.add(google);
    // mapLauncherMenuItems.add(yandex);
    // if (await mapLauncher.MapLauncher.isMapAvailable(
    //     mapLauncher.MapType.apple)) {
    //   mapLauncherMenuItems.add(apple);
    // }

    // mapLauncherMenuItems.add(_cancel);
  }

  // BottomMenuItem get google => BottomMenuItem(
  //     title: translate(context, LanguageConstants.of(context).openMapGoogle),
  //     iconColor: Colors.white);

  // BottomMenuItem get yandex => BottomMenuItem(
  //     title: translate(context, LanguageConstants.of(context).openMapYandex),
  //     iconColor: Colors.white);

  // BottomMenuItem get apple => BottomMenuItem(
  //     title: translate(context, LanguageConstants.of(context).openMapApple),
  //     iconColor: Colors.white);

  // BottomMenuItem get _cancel => BottomMenuItem(
  //     title: translate(context, LanguageConstants.of(context).cancel),
  //     iconColor: Colors.white);

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
                    //  NothcWidget(),
                    //_listMenuItems,
                  ],
                )),
          ),
        );
      },
    );
  }

  // Widget get _listMenuItems => ListView.builder(
  //       shrinkWrap: true,
  //       itemCount: mapLauncherMenuItems.length,
  //       itemBuilder: (context, index) => ListTile(
  //         subtitle: Divider(),
  //         title: Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: <Widget>[
  //             mapLauncherMenuItems[index].image != null
  //                 ? Image.asset(
  //                     mapLauncherMenuItems[index].image,
  //                     height: UIHelper.dynamicHeight(96),
  //                   )
  //                 : Container(
  //                     width: UIHelper.dynamicHeight(96),
  //                   ),
  //             SizedBox(
  //               width: UIHelper.dynamicWidth(50),
  //             ),
  //             Text(
  //               mapLauncherMenuItems[index].title,
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                 fontSize: UIHelper.Space20,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //           ],
  //         ),
  //         onTap: () async => await selectMapLaunch(index),
  //       ),
  //     );

  selectMapLaunch(int index) async {
    if (index == 0) {
      // Google Maps
      if (await mapLauncher.MapLauncher.isMapAvailable(mapLauncher.MapType.google)) {
        await launchMap(mapType: mapLauncher.MapType.google);
      } else {
        launchMaps('https://www.google.com/maps/@${currentSelectStation.latitude},${currentSelectStation.longitude},12z');
      }
    } else if (index == 1) {
      // Yandex
      if (await mapLauncher.MapLauncher.isMapAvailable(mapLauncher.MapType.yandexNavi)) {
        await launchMap(mapType: mapLauncher.MapType.yandexNavi);
      } else {
        launchMaps(
            'https://maps.yandex.com.tr/?mode=routes&rtext=${currentSelectStation.latitude},${currentSelectStation.longitude}~${currentUserLocation.latitude},${currentUserLocation.longitude}&z=12');
      }
    } else if (index == 2) {
      //Apple
      if (await mapLauncher.MapLauncher.isMapAvailable(mapLauncher.MapType.apple)) {
        await launchMap(mapType: mapLauncher.MapType.apple);
      } else {
        navigator.pop();
      }
    } else {
      navigator.pop();
    }
  }

  Future launchMap({mapLauncher.MapType mapType}) {
    return mapLauncher.MapLauncher.launchMap(
        mapType: mapType, coords: mapLauncher.Coords(currentSelectStation.latitude, currentSelectStation.longitude), title: "", description: "");
  }

  Future<Null> displayPrediction(places.Prediction p) async {
    removeSearchPin();

    await getAllNoticies(isFilter: false, isFilterReset: true);

    if (p != null) {
      places.PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;

      Marker m = Marker(
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
      } catch (e) {}
    }
  }

  removeSearchPin() {
    try {
      markerSet.remove(markerSet.firstWhere((Marker marker) => marker.markerId.value == SEARCHED_MARKER_ID));
    } catch (e) {
      print("Marker Yok");
    }
  }

  @override
  void dispose() {
    newLocationManager.stopService();
    newLocationManager = null;
    super.dispose();
  }
}
