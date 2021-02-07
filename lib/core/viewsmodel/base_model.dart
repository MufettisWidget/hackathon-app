import 'package:flutter/material.dart';

import '../../locator.dart';
import '../enum/viewstate.dart';
import '../services/navigation_service.dart';

//Sayfaların inherit(miras almak) edildiği model
class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  NavigationService get navigator {
    return locator<NavigationService>();
  }

  void setState(ViewState state) {
    if (state == _state)
      return;
    else
      _state = state;

    try {
      notifyListeners();
    } catch (e) {
      print("BM: notifyListeners ERROR");
    }
  }

  @override
  void notifyListeners() {
    try {
      super.notifyListeners();
    } catch (e) {
      print("BM: notifyListeners ERROR");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
