import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../screen/customer/customer_login.dart';
import '../../screen/home/home_view.dart';
import '../../screen/lef_driver_widget.dart';
import '../../screen/notice/do_notice.dart';
import '../../screen/tab_menu/all_notice_view.dart';
import '../../screen/tab_menu/customer_map.dart';
import '../shared_prefernces_api.dart';
import 'base_model.dart';

class MainViewModel extends BaseModel {
  BuildContext _context;

  BuildContext get context => _context;

  static GlobalKey<ScaffoldState> mainScaffoldKey = GlobalKey();

  HomeView homeView;
  CustomerLogin customerLogin;
  DoNoticeView doNoticeView;
  int currentIndex = 0;
  LeftDrawerWidget leftDrawerWidget;

  List<Widget> bottomBarChildren = [
    CustomerNoticeMapView(),
    AllNoticeView(),
    DoNoticeView(),
  ];

  void goToNoticeList() {
    currentIndex = 3;
    notifyListeners();
  }

  void goToMapNoticeView() {
    currentIndex = 1;
    notifyListeners();
  }

  MainViewModel() {
    homeView = HomeView(
      goToNoticeList: goToNoticeList,
      goToMapNoticeView: goToMapNoticeView,
    );

    doNoticeView = DoNoticeView();
    customerLogin = CustomerLogin();
    bottomBarChildren.insert(0, homeView);
    if (SharedManager().jwtToken != null)
      bottomBarChildren.insert(2, doNoticeView);
    else
      bottomBarChildren.insert(2, customerLogin);

    leftDrawerWidget = LeftDrawerWidget(
      onChangeTokenStatus: () {
        if (currentIndex == 0) {
          if (homeView.homeViewModel != null) {
            homeView.homeViewModel.getHomeData();
          } else {}
        }
      },
      returnMain: () {
        notifyListeners();
      },
      returnMainConverted: () {
        homeView.homeViewModel.updateHomeDataPoint();
      },
    );
  }

  void onTabTapped(int index) async {
    currentIndex = index;
    notifyListeners();
  }

  static openLeftMenu() {
    mainScaffoldKey.currentState.openDrawer();
  }

  @override
  void setContext(BuildContext context) {
    this._context = context;
  }
}
