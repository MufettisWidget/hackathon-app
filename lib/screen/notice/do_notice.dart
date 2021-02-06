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
    return BaseView<DoNoticeViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        _doNoticeViewModel = model;
      },
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
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
    return Column(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
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
      if (mounted)
        setState(() {
          isVisible = true;
        });
    }
  }

  void gotoCameraPage() async {
    WidgetsFlutterBinding.ensureInitialized();

    final cameras = await availableCameras();

    final firstCamera = cameras.first;
    Notice notice =
        new Notice(controllerCity.text, controllerDisctirct.text, controllerNeighborhood.text, controllerStreet.text, controllerStreetNo.text);
    notice.latitude = latitude;
    notice.longitude = longitude;
    Navigator.push(context, MaterialPageRoute(builder: (_context) => TakePictureScreen(camera: firstCamera, notice: notice)));
  }
}
