import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../enum/paged_name.dart';

//sayfa routerları için
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final _removeAllOldRoutes = (Route<dynamic> route) => false;

  Future<dynamic> navigateTo(Pages routeType, [Object arguments = '', int extraVal]) async {
    return await navigatorKey.currentState.pushNamed(_named(routeType), arguments: arguments);
  }

  Future<void> pop() async {
    if (isPop()) {
      return navigatorKey.currentState.pop();
    }
    return null;
  }

  bool isPop() {
    return navigatorKey.currentState.canPop();
  }

  Future<dynamic> navigateToRemove(Pages routeType, [Object arguments = '']) async {
    return await navigatorKey.currentState.pushNamedAndRemoveUntil(_named(routeType), _removeAllOldRoutes, arguments: arguments);
  }

  void fullScreenPopup() {
    navigatorKey.currentState.push(MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return Container();
        },
        fullscreenDialog: true));
  }

  String _named(Pages page) {
    switch (page) {
      case Pages.Splash:
        return '/splash';

      case Pages.Login:
        return '/login';

      case Pages.Signin:
        return '/signin';

      case Pages.MyAccount:
        return '/myAccount';

      case Pages.Home:
        return '/main';

      case Pages.DoNotice:
        return '/doNotice';

      case Pages.MyNotice:
        return '/myNotice';

      case Pages.News:
        return '/newsRoute';

      default:
        return '/';
    }
  }
}
