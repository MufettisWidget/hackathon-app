import 'package:get_it/get_it.dart';

import 'core/services/navigation_service.dart';
import 'core/viewsmodel/all_notice_view_model.dart';
import 'core/viewsmodel/badge_menu_view_model.dart';
import 'core/viewsmodel/camera_notice_view_model.dart';
import 'core/viewsmodel/change_password_view_model.dart';
import 'core/viewsmodel/customer_login_view_model.dart';
import 'core/viewsmodel/customer_notice_map_view_model.dart';
import 'core/viewsmodel/do_notice_view_model.dart';
import 'core/viewsmodel/forgot_password_view_model.dart';
import 'core/viewsmodel/home_view_model.dart';
import 'core/viewsmodel/lef_drawer_view_model.dart';
import 'core/viewsmodel/main_view_model.dart';
import 'core/viewsmodel/my_notice_view_model.dart';
import 'core/viewsmodel/my_profile_info_view_model.dart';
import 'core/viewsmodel/my_profile_view_model.dart';
import 'core/viewsmodel/new_detail_view_model.dart';
import 'core/viewsmodel/notice_detail_view_model.dart';
import 'core/viewsmodel/notice_explanation_view_model.dart';
import 'core/viewsmodel/splash_view_model.dart';
import 'core/viewsmodel/succes_share_view_model.dart';
import 'core/viewsmodel/change_mail_address_view_model.dart';
import 'core/viewsmodel/customer_add_view_model.dart';
import 'core/viewsmodel/renew_password_view_model.dart';
import 'core/viewsmodel/my_notice_detail_view_model.dart';

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
  locator.registerFactory(() => ChangePasswordViewModel());
  locator.registerFactory(() => NewDetailViewModel());
  locator.registerFactory(() => CustomerAddViewModel());
  locator.registerFactory(() => CameraNoticeViewModel());
  locator.registerFactory(() => ChangeMailAddressViewModel());
  locator.registerFactory(() => NoticeDetailViewModel());
  locator.registerFactory(() => RenewPasswordViewModel());
  locator.registerFactory(() => NoticeExplanationdViewModel());
  locator.registerFactory(() => ForgotPasswordViewModel());
  locator.registerFactory(() => MyNoticeDetailViewModel());
  locator.registerFactory(() => MyProfileInfoViewModel());
  locator.registerFactory(() => MyProfileViewModel());
}
