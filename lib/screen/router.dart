import 'package:flutter/material.dart';

import 'customer/customer_add.dart';
import 'customer/customer_login.dart';
import 'customer/my_notice.dart';
import 'customer/my_profile.dart';
import 'main_view.dart';
import 'notice/do_notice.dart';
import 'splash_view.dart';

class Router {
  static const String splashRoute = '/';
  static const String mainRoute = '/main';
  static const String doNotice = '/doNotice';
  static const String noticeDetail = '/noticeDetail';
  static const String customerLogin = '/login';
  static const String myNotice = '/myNotice';
  static const String newsRoute = '/newsRoute';
  static const String signIn = '/signin';
  static const String myAccount = '/myAccount';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case doNotice:
        return MaterialPageRoute(builder: (_) => DoNoticeView());
        break;
      case splashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());
      case mainRoute:
        return MaterialPageRoute(builder: (_) => MainView());
      case customerLogin:
        return MaterialPageRoute(builder: (_) => CustomerLogin());
      case myNotice:
        return MaterialPageRoute(builder: (_) => MyNoticeView());
      case signIn:
        return MaterialPageRoute(builder: (_) => CustomerAddView());

      case myAccount:
        return MaterialPageRoute(builder: (_) => ProfileView());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
