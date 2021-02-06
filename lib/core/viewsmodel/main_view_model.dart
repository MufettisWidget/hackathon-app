import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../screen/customer/customer_login.dart';
import '../../screen/home/home_view.dart';
import '../../screen/lef_driver_widget.dart';
import '../../screen/notice/do_notice.dart';
import '../../screen/tab_menu/all_news.dart';
import '../../screen/tab_menu/all_notice_view.dart';
import '../../screen/tab_menu/customer_map.dart';
import '../core_helper.dart';
import '../enum/analitic_constants.dart';
import '../shared_prefernces_api.dart';
import 'base_model.dart';

class MainViewModel extends BaseModel {
  BuildContext _context;

  BuildContext get context => _context;

  static GlobalKey<ScaffoldState> mainScaffoldKey = GlobalKey();

  //SharedManager _sharedManager = new SharedManager();

  // Campaigns campaignDetail;
  // List<News> news = new List();
  // News newsDetail;

  HomeView homeView;
  AllNewsView allNews;
  CustomerLogin customerLogin;
  DoNoticeView doNoticeView;
  int currentIndex = 0;
  LeftDrawerWidget leftDrawerWidget;
  // NotificationListRequestModel notificationListRequestModel =
  //     new NotificationListRequestModel();

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
    // _apiService = new ApiServices();
    // campaignRequestModel = new CampaignRequestModel();

    homeView = HomeView(
      goToNoticeList: goToNoticeList,
      goToMapNoticeView: goToMapNoticeView,
    );

    allNews = AllNewsView();
    doNoticeView = DoNoticeView();
    customerLogin = CustomerLogin();
    bottomBarChildren.insert(0, homeView);
    if (SharedManager().jwtToken != null)
      bottomBarChildren.insert(2, doNoticeView);
    else
      bottomBarChildren.insert(2, customerLogin);

    bottomBarChildren.insert(4, allNews);

    leftDrawerWidget = LeftDrawerWidget(
      onChangeTokenStatus: () {
        //TODO başka sayfadaysa burayı kapat
        if (currentIndex == 0) {
          if (homeView.homeViewModel != null) {
            homeView.homeViewModel.getHomeData();
          } else {
            // homeView = HomeView(
            //   goToNoticeList: goToNoticeList,
            //   goToMapNoticeView: goToMapNoticeView,
            // );
            // homeView.homeViewModel.getHomeData();
          }
        }
        // else if (currentIndex == 4) {
        //   //  customerNoticeMapView.customerNoticeMapView.notifyListeners();
        // }
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
    if (index == 0) {
      await CoreHelper.analyticsScreenLog(screen: AnalyticsConstants.ANALYTICS_HOME_VIEW);
    } else if (index == 1) {
      await CoreHelper.analyticsScreenLog(screen: AnalyticsConstants.ANALYTICS_STATION_VIEW);
    } else if (index == 2) {
      await CoreHelper.analyticsScreenLog(screen: AnalyticsConstants.ANALYTICS_ANNOUNCEMENT_VIEW);
    } else if (index == 3) {
      await CoreHelper.analyticsScreenLog(screen: AnalyticsConstants.ANALYTICS_PAYMENT_SELECTION_VIEW);
    } else if (index == 4) {
      await CoreHelper.analyticsScreenLog(screen: AnalyticsConstants.ANALYTICS_PAYMENT_SELECTION_VIEW);
    } else if (index == 4) {
      await CoreHelper.analyticsScreenLog(screen: AnalyticsConstants.ANALYTICS_PAYMENT_SELECTION_VIEW);
    }

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
