import 'package:get_it/get_it.dart';

import 'core/services/navigation_service.dart';
import 'core/viewsmodel/all_notice_view_model.dart';
import 'core/viewsmodel/badge_menu/badge_menu_view_model.dart';
import 'core/viewsmodel/customer_login_view_model.dart';
import 'core/viewsmodel/customer_notice_map_view_model.dart';
import 'core/viewsmodel/do_notice_view_model.dart';
import 'core/viewsmodel/home_view_model.dart';
import 'core/viewsmodel/lef_drawe_view_model.dart';
import 'core/viewsmodel/main_view_model.dart';
import 'core/viewsmodel/my_notice_view_model.dart';
import 'core/viewsmodel/news_view_model.dart';
import 'core/viewsmodel/splash_view_model.dart';
import 'core/viewsmodel/succes_share_view_model.dart';

GetIt locator = GetIt.instance;

void initLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerFactory(() => MyNoticeViewModel());
  locator.registerFactory(() => SplashViewModel());
  locator.registerFactory(() => MainViewModel());
  locator.registerFactory(() => CustomerNoticeMapViewModel());
  locator.registerFactory(() => LeftDrawerViewModel());
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => BadgeMenuViewModel());
  locator.registerFactory(() => AllNoticeViewModel());
  locator.registerFactory(() => CustomerLoginViewModel());
  locator.registerFactory(() => DoNoticeViewModel());
  locator.registerFactory(() => SuccesShareViewModel());
  locator.registerFactory(() => NewsViewModel());
}
