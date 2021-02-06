import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../core/shared_prefernces_api.dart';
import '../../core/viewsmodel/home_view_model.dart';
import '../../main.dart';
import '../../model/lat_long.dart';
import '../../shared/style/ui_helper.dart';
import '../../ui/views/baseview.dart';
import 'badge_menu.dart';

class HomeView extends StatefulWidget {
  HomeViewModel homeViewModel;

  Function goToNoticeList;
  Function goToMapNoticeView;
  Function goToDoNotice;

  HomeView({Key key, this.homeViewModel, this.goToNoticeList, this.goToMapNoticeView, this.goToDoNotice}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  Future _future;
  HomeViewModel _homeViewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        _homeViewModel = model;
        widget.homeViewModel = model;
        _future = _homeViewModel.getHomeData();
      },
      builder: (context, model, child) {
        return FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              _homeViewModel.setHomeDataShared();
              return _buildMainContent();
            } else if (snapshot.hasError) {
              return Container(
                  color: Colors.white,
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.all(UIHelper.dynamicHeight(30)),
                    child: Text(
                      "Bir hatayla karşılaşıldı. \n Lütfen internet bağlantınızı kontrol ediniz.",
                      style: TextStyle(fontSize: UIHelper.dynamicScaleSp(44)),
                      textAlign: TextAlign.center,
                    ),
                  )));
            } else {
              return _buildMainContent();
            }
          },
        );
      },
    );
  }

  Widget _buildMainContent() {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: BadgeMenuView(
                onPress: () {
                  _homeViewModel.openLeftDrawer();
                },
              ),
              expandedHeight: UIHelper.dynamicHeight(150),
              floating: true,
              pinned: true,
              centerTitle: true,
              title: Container(
                padding: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Image.asset(
                    "assets/icons/appicon.png",
                    scale: 5,
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ClipPath(
                clipper: MyClip(),
                child: Container(
                  height: 60.0,
                  color: UIHelper.PEAR_PRIMARY_COLOR,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[SizedBox(height: 10.0)],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: SharedManager().jwtToken != null && SharedManager().loginRequest != null,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Son Bildirimlerim",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey, fontSize: 22.0),
                      ),
                      InkWell(
                        onTap: () {
                          _homeViewModel.gotoMyNoticeView();
                        },
                        child: Text(
                          "Hepsini Gör",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey, fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                child: Container(
                  height: 200.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      if (SharedManager().loginRequest != null)
                        if (SharedManager().loginRequest.noticies != null)
                          for (var item in SharedManager().loginRequest.noticies) getItem(item.photoName),
                    ],
                  ),
                ),
                visible: SharedManager().loginRequest != null,
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "En Belediyeler",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.blueGrey),
                    ),
                  ],
                ),
              ),
              getSmallItem(SharedManager().mostCityCount, SharedManager().mostCityName, "En Çok Bildirim Alan Büyük Şehir"),
              getSmallItem(SharedManager().mostDistrictCount, SharedManager().mostDistrictName, "En Çok Bildirim Alan Büyük İlçe"),
              getSmallItem(SharedManager().mostCitySolitionCount, SharedManager().mostCitySolitionName, "En İyi Çözüm Oranı Büyük Şehir"),
              getSmallItem(SharedManager().mostDistrictSolitionCount, SharedManager().mostDistrictSolitionName, "En İyi Çözüm Oranı İlçe"),
            ],
          ),
        ));
  }

  void getLocationData() {
    if (SharedManager().loginRequest == null) {
      _getCurrentLocation;
    }
  }

  Future<String> get _getCurrentLocation async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(double.parse(position.latitude.toStringAsFixed(7)), double.parse(position.longitude.toStringAsFixed(7)));

    SharedManager().homeLocation.lat = position.latitude;
    SharedManager().homeLocation.lng = position.longitude;

    HomeLocationModel aa = new HomeLocationModel();
    aa.lat = position.latitude;
    aa.lng = position.longitude;
  }
}

getSmallItem(count, name, flavor) {
  return Padding(
    padding: EdgeInsets.all(16.0),
    child: Card(
      child: Row(
        children: <Widget>[
          SizedBox(width: 10.0),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "$name",
                style: TextStyle(fontSize: 20.0, color: Colors.blueGrey, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.0),
              Text(
                "$flavor",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
              )
            ],
          )),
          Column(
            children: <Widget>[
              Icon(
                Icons.upgrade_sharp,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(width: 20.0),
          ClipPath(
            clipper: MyClip2(),
            child: Container(
              width: 70.0,
              height: 70.0,
              color: UIHelper.PEAR_PRIMARY_COLOR,
              child: Center(
                child: Text(
                  "$count",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

class MyClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 60.0);
    path.quadraticBezierTo(size.width - 70.0, size.height, size.width / 2, size.height - 20);
    path.quadraticBezierTo(size.width / 3.0, size.height - 32, 0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class MyClip2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(10, size.height / 2 + 20, 5, size.height / 2);
    path.quadraticBezierTo(0, size.height / 3, 10, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
