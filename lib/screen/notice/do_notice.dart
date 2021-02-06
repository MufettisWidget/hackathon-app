import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/services/location_services.dart';
import '../../core/shared_prefernces_api.dart';
import '../../core/viewsmodel/do_notice_view_model.dart';
import '../../mixin/validation_mixin.dart';
import '../../model/notice.dart';
import '../../shared/style/ui_helper.dart';
import '../../ui/views/baseview.dart';
import 'camera_notice.dart';

class DoNoticeView extends StatefulWidget {
  // DoNoticeView({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => DoNoticeState();
}

class DoNoticeState extends State<DoNoticeView> with ValidationMixin {
  DoNoticeViewModel _doNoticeViewModel;
  final formKey = GlobalKey<FormState>();
  CameraPosition _currentPosition;
  TextEditingController controllerStreet;
  TextEditingController controllerCity;
  TextEditingController controllerDisctirct;
  TextEditingController controllerSubStreet;
  TextEditingController controllerNeighborhood;
  TextEditingController controllerStreetNo;
  double latitude;
  double longitude;
  SharedManager _sharedManager = new SharedManager();
  LocationService _locationService;
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  BitmapDescriptor pinLocationIcon;

  LatLng pinPosition = LatLng(41.016276, 29.1180298);
  bool isVisible = false;
  @override
  void initState() {
    super.initState();
    controllerCity = TextEditingController(text: "");
    controllerDisctirct = TextEditingController(text: "");
    controllerStreet = TextEditingController(text: "");
    controllerSubStreet = TextEditingController(text: "");
    _getCurrentLocation;
    _currentPosition = new CameraPosition(
      bearing: 0,
      target: LatLng(SharedManager().homeLocation.lat, SharedManager().homeLocation.lng),
      zoom: 15.0,
    );
    controllerNeighborhood = TextEditingController(text: "");
    controllerStreetNo = TextEditingController(text: "");
    setCustomMapPin();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), 'assets/destination_map_marker.png');
  }

  @override
  Widget build(BuildContext context) {
    //_isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return BaseView<DoNoticeViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        _doNoticeViewModel = model;
      },
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            //can
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => _doNoticeViewModel.goHome(),
            ),
            title: Text("Bildirim Yap"),
            backgroundColor: UIHelper.PEAR_PRIMARY_COLOR,
            actions: <Widget>[
              Visibility(
                child: IconButton(
                  icon: const Icon(Icons.navigate_next),
                  tooltip: 'Kaydet',
                  onPressed: () {
                    gotoCameraPage();
                  },
                ),
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: isVisible,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(25.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    city(),
                    dictrict(),
                    neighborhood(),
                    street(),
                    streetno(),
                    mapStreet(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget mapStreet() {
    // if (latitude != null) {
    return Column(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width, // or use fixed size like 200
        height: 250,
        child: GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          markers: _markers,
          initialCameraPosition: _currentPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    ]);
  }

  Widget city() {
    return TextFormField(
        controller: controllerCity, decoration: InputDecoration(labelText: "Şehir", hintText: "Şehir"), showCursor: true, readOnly: true);
  }

  Widget dictrict() {
    return TextFormField(
        controller: controllerDisctirct, decoration: InputDecoration(labelText: "İlçe", hintText: "İlçe"), showCursor: true, readOnly: true);
  }

  Widget neighborhood() {
    return TextFormField(
        controller: controllerNeighborhood, decoration: InputDecoration(labelText: "Mahalle", hintText: "Mahalle"), showCursor: true, readOnly: true);
  }

  Widget street() {
    return TextFormField(
        controller: controllerStreet,
        decoration: InputDecoration(labelText: "Cadde-Sokak", hintText: "Cadde-Sokak"),
        showCursor: true,
        readOnly: true);
  }

  Widget streetno() {
    return TextFormField(
        controller: controllerStreetNo, decoration: InputDecoration(labelText: "No", hintText: "No"), showCursor: true, readOnly: false);
  }

  Widget subStreet() {
    return TextFormField(
        controller: controllerSubStreet,
        decoration: InputDecoration(
          labelText: "Sokak",
          hintText: "Sokak",
        ),
        showCursor: false,
        readOnly: false);
  }

//   Future<String> get _getCurrentLocation async {
//     //  if (_sharedManager.homeLocation != null) {
//     //   currentUserLocation = new LatLng(_sharedManager.homeLocation.lat, _sharedManager.homeLocation.lng);
//     // }

//     latitude = _sharedManager.homeLocation.lat;
//     longitude = _sharedManager.homeLocation.lng;

//     // _locationService = new LocationService(
//     //     isLocationTrack: true,
//     //     onChangeLocation: () {
//     //       // currentUserLocation = _locationService.currentLocation;
//     //       // addMarkerUser();
//     //       // print(_locationService.currentLocation.latitude);
//     //     },
//     //     onRejectPermission: () {
//     //       // addMarkerUser();
//     //       // snackBarWarningMessage(translate(context, LanguageConstants.of(context).warningLocationPermission));
//     //     },
//     //     onCloseGPSListener: () {
//     //       // addMarkerUser();
//     //       // snackBarWarningMessage(translate(context, LanguageConstants.of(context).warningOpenGps));
//     //     });
// //  Future<List<Placemark>> placemark =  Geolocator()
// //         .placemarkFromCoordinates(_sharedManager.homeLocation.lat, _sharedManager.homeLocation.lng);
//     // Placemark place = placemark.t[0];
//     controllerCity.text = _sharedManager.homeLocation.city;
//     // controllerDisctirct.text = place.subAdministrativeArea.toString();
//     // controllerNeighborhood.text = place.subLocality.toString();
//     // controllerStreet.text = place.thoroughfare.toString();
//     // controllerStreetNo.text = place.subThoroughfare.toString();

//     // controllerSubStreet.text = place.thoroughfare.toString();
//   }

  // ignore: missing_return
  Future<String> get _getCurrentLocation async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(double.parse(position.latitude.toStringAsFixed(7)), double.parse(position.longitude.toStringAsFixed(7)));
    _currentPosition = CameraPosition(
      target: LatLng(double.parse(position.latitude.toStringAsFixed(7)), double.parse(position.longitude.toStringAsFixed(7))),
      zoom: 19.4746,
    );

    latitude = position.latitude;
    longitude = position.longitude;

    Placemark place = placemark[0];
    controllerCity.text = place.administrativeArea.toString();
    controllerDisctirct.text = place.subAdministrativeArea.toString();
    controllerNeighborhood.text = place.subLocality.toString();
    controllerStreet.text = place.thoroughfare.toString();
    controllerStreetNo.text = place.subThoroughfare.toString();

    if (controllerCity.text != "") {
      setState(() {
        isVisible = true;
      });
    }
  }

  void gotoCameraPage() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;
    Notice notice =
        new Notice(controllerCity.text, controllerDisctirct.text, controllerNeighborhood.text, controllerStreet.text, controllerStreetNo.text);
    notice.latitude = latitude;
    notice.longitude = longitude;
    Navigator.push(context, MaterialPageRoute(builder: (_context) => TakePictureScreen(camera: firstCamera, notice: notice)));
    // await Navigator.push(context,
    //     MaterialPageRoute(builder: (_context) => CameraExampleHome(notice)));
  }
}
