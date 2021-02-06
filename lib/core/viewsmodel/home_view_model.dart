import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_manager/location_manager.dart';

import '../../model/home/home_request_model.dart';
import '../../model/lat_long.dart';
import '../../model/notice.dart';
import '../enum/paged_name.dart';
import '../services/location_services.dart';
import '../shared_prefernces_api.dart';
import 'base_model.dart';
import 'main_view_model.dart';

class HomeViewModel extends BaseModel {
  BuildContext _context;

  BuildContext get context => _context;

  int currentPosition = 0;
  int bannerListSize = 0;
  SharedManager sharedManager = new SharedManager();

  HomeRequestModel _homeRequestModel;
  LocationManager newLocationManager;

  List<Notice> customerNotice = null;

  LocationService _locationService;

  SharedManager _sharedManager = new SharedManager();
  LatLng currentUserLocation;

  bool pointVisibility = false;

  HomeViewModel() {
    customerNotice = new List<Notice>();
    _homeRequestModel = new HomeRequestModel();
    newLocationManager = LocationManager();
  }

  @override
  void setContext(BuildContext context) {
    this._context = context;
  }

  Future getHomeData() async {
    try {
      newLocationManager.getLocation(
        onLocationValue: (val) {
          currentUserLocation = val;
          _sharedManager.homeLocation = HomeLocationModel(lat: currentUserLocation.latitude, lng: currentUserLocation.longitude);
          setData(lat: currentUserLocation.latitude, lng: currentUserLocation.longitude);
        },
        isLocationTrack: false,
        onRejectPermission: () {
          currentUserLocation = new LatLng(40.9801401, 29.0735152);
          _sharedManager.homeLocation = HomeLocationModel(lat: currentUserLocation.latitude, lng: currentUserLocation.longitude);
          setData();
        },
      );
    } catch (e) {
      setData();
    }

    notifyListeners();
  }

  setHomeDataShared() {}

  openLeftDrawer() {
    MainViewModel.openLeftMenu();
  }

  gotoMyNoticeView() {
    navigator.navigateTo(Pages.MyNotice);
  }

  updateHomeDataPoint() {
    notifyListeners();
  }

  setData({double lat, double lng}) async {
    _homeRequestModel.token = SharedManager().jwtToken;
    _homeRequestModel.latitude = lat;
    _homeRequestModel.longitude = lng;
  }

  String getPointVal() {
    if (_sharedManager.jwtToken == null) {
      return null;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
