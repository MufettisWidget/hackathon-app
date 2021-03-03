import '../../main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_manager/location_manager.dart';

import '../../model/home/home_request_model.dart';
import '../../model/lat_long.dart';
import '../../model/notice.dart';
import '../enum/paged_name.dart';
import '../shared_prefernces_api.dart';
import 'base_model.dart';
import 'main_view_model.dart';

class HomeViewModel extends BaseModel {
  BuildContext _context;

  BuildContext get context => _context;

  int currentPosition = 0;
  int bannerListSize = 0;
  SharedManager sharedManager = SharedManager();

  HomeRequestModel _homeRequestModel;
  LocationManager newLocationManager;

  List<Notice> customerNotice;

  final SharedManager _sharedManager = SharedManager();
  LatLng currentUserLocation;

  bool pointVisibility = false;

  HomeViewModel() {
    customerNotice = <Notice>[];
    _homeRequestModel = HomeRequestModel();
    newLocationManager = LocationManager();
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  Future getHomeData() async {
    try {
      await newLocationManager.getLocation(
        onLocationValue: (val) {
          currentUserLocation = val;
          _sharedManager.homeLocation = HomeLocationModel(lat: currentUserLocation.latitude, lng: currentUserLocation.longitude);
          setData(lat: currentUserLocation.latitude, lng: currentUserLocation.longitude);
        },
        isLocationTrack: false,
        onRejectPermission: () {
          currentUserLocation = LatLng(40.9801401, 29.0735152);
          _sharedManager.homeLocation = HomeLocationModel(lat: currentUserLocation.latitude, lng: currentUserLocation.longitude);
          setData();
        },
      );
    } catch (e) {
      setData();
    }

    notifyListeners();
  }

  // ignore: always_declare_return_types
  setHomeDataShared() async {}

  // ignore: always_declare_return_types
  openLeftDrawer() async {
    return MainViewModel.openLeftMenu();
  }

  // ignore: always_declare_return_types
  gotoMyNoticeView() {
    navigator.navigateTo(Pages.MyNotice);
  }

  // ignore: always_declare_return_types
  updateHomeDataPoint() {
    notifyListeners();
  }

  // ignore: always_declare_return_types
  setData({double lat, double lng}) async {
    _homeRequestModel.token = SharedManager().jwtToken;
    _homeRequestModel.latitude = lat;
    _homeRequestModel.longitude = lng;
  }

  // ignore: missing_return
  Future<String> getPointVal() async {
    if (_sharedManager.jwtToken == null) {
      return null;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

InkWell getItem(img) {
  return InkWell(
      child: Container(
    margin: EdgeInsets.all(2.0),
    width: 150.0,
    decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(baseUrl + 'UploadFile/' + img + '.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10.0)),
  ));
}
