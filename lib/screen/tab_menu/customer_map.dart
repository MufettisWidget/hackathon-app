import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../../core/core_helper.dart';
import '../../core/enum/viewstate.dart';
import '../../core/viewsmodel/customer_notice_map_view_model.dart';
import '../../shared/style/ui_helper.dart';
import '../../ui/views/baseview.dart';
import '../home/badge_menu.dart';

class CustomerNoticeMapView extends StatefulWidget {
  CustomerNoticeMapView({Key key}) : super(key: key);

  @override
  _CustomerNoticeMapViewState createState() => _CustomerNoticeMapViewState();
}

class _CustomerNoticeMapViewState extends State<CustomerNoticeMapView> {
  CustomerNoticeMapViewModel _customerNoticeMapViewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<CustomerNoticeMapViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        _customerNoticeMapViewModel = model;
      },
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.grey,
          key: _customerNoticeMapViewModel.customerNoticeScaffoldKey,
          body: Stack(
            children: <Widget>[
              _buildGoogleMap(_customerNoticeMapViewModel.mapController),
              _customerNoticeMapViewModel.state == ViewState.Busy ? Center(child: CircularProgressIndicator()) : Container(),
              Column(
                children: <Widget>[
                  _buildAppBar(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  _buildAppBar() {
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {
            final p = await PlacesAutocomplete.show(
                logo: Container(
                  height: 0,
                ),
                mode: Mode.overlay,
                context: context,
                hint: 'Ara',
                language: "tr",
                components: [Component(Component.country, "tr")],
                apiKey: CoreHelper.kGoogleApiKey);
            _customerNoticeMapViewModel.displayPrediction(p);
          },
        ),
      ],
      leading: BadgeMenuView(
        onPress: () {
          _customerNoticeMapViewModel.openLeftDrawer();
        },
      ),
      title: Padding(
        padding: EdgeInsets.only(top: UIHelper.dynamicHeight(20)),
        child: Container(
          child: Image.asset(
            "assets/icons/appicon.png",
            scale: 5,
          ),
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  _buildGoogleMap(GoogleMapController mapController) {
    return GoogleMap(
        myLocationButtonEnabled: false,
        myLocationEnabled: false,
        mapType: MapType.normal,
        mapToolbarEnabled: false,
        compassEnabled: false,
        initialCameraPosition: CameraPosition(
          zoom: 10,
          target: LatLng(_customerNoticeMapViewModel.currentUserLocation.latitude, _customerNoticeMapViewModel.currentUserLocation.longitude),
        ),
        markers: _customerNoticeMapViewModel.selectedMarker.length != 0
            ? _customerNoticeMapViewModel.selectedMarker
            : _customerNoticeMapViewModel.markerSet,
        polylines: _customerNoticeMapViewModel.polyline,
        onMapCreated: _customerNoticeMapViewModel.onMapCreated);
  }

  void stationListModalSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(UIHelper.dynamicHeight(40)), topRight: Radius.circular(UIHelper.dynamicHeight(40))),
        ),
        builder: (builder) {
          return FractionallySizedBox(
            heightFactor: 0.85,
            child: Container(
              child: Column(
                children: <Widget>[],
              ),
            ),
          );
        });
  }

  Widget _paddingListItem({Widget child}) {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil.instance.setHeight(12),
          bottom: ScreenUtil.instance.setHeight(12),
          left: ScreenUtil.instance.setHeight(60),
          right: ScreenUtil.instance.setHeight(50)),
      child: child,
    );
  }

  Padding buildStationDetailImage({Widget image}) {
    return Padding(
      padding: EdgeInsets.only(right: UIHelper.dynamicScaleSp(30)),
      child: image,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
