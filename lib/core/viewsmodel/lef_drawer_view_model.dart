import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../model/user.dart';
import '../enum/paged_name.dart';
import '../enum/viewstate.dart';
import '../shared_prefernces_api.dart';
import 'base_model.dart';

class LeftDrawerViewModel extends BaseModel with WidgetsBindingObserver {
  BuildContext _context;

  BuildContext get context => _context;

  User customerDetail;

  VoidCallback onChangeTokenStatusModel;
  VoidCallback returnMain;
  VoidCallback returnMainConverted;

  SharedManager sharedManager = new SharedManager();

  LeftDrawerViewModel() {
    getCustomer();
  }

  void setContext(BuildContext context) {
    this._context = context;
  }

  Future getCustomer() async {
    if (sharedManager.jwtToken != null) {
      customerDetail = sharedManager.loginRequest;
      notifyListeners();
    }
  }

  navigateLeftMenu(Pages _page) async {
    navigator.pop();
    final response = await navigator.navigateTo(_page);

    if (response == "changeTokenStatus") {
      onChangeTokenStatusModel();
    } else if (response == "returnMain") {
      returnMain();
    } else if (response == "returnConvertedTlPoint") {
      returnMainConverted();
    }
  }

  logout() {
    onChangeTokenStatusModel();
    // sharedManager.removeNotifications();
    customerDetail = null;
    setState(ViewState.Busy);
    sharedManager.logOut();

    setState(ViewState.Idle);
    notifyListeners();
  }
}
