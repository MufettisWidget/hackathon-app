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

  SharedManager sharedManager = SharedManager();

  LeftDrawerViewModel() {
    getCustomer();
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  Future getCustomer() async {
    if (sharedManager.jwtToken != null) {
      customerDetail = sharedManager.loginRequest;
      notifyListeners();
    }
  }

  // ignore: always_declare_return_types
  navigateLeftMenu(Pages _page) async {
    await navigator.pop();
    final response = await navigator.navigateTo(_page);

    if (response == 'changeTokenStatus') {
      onChangeTokenStatusModel();
    } else if (response == 'returnMain') {
      returnMain();
    } else if (response == 'returnConvertedTlPoint') {
      returnMainConverted();
    }
  }

  // ignore: always_declare_return_types
  logout() async {
    onChangeTokenStatusModel();

    customerDetail = null;
    setState(ViewState.Busy);
    sharedManager.logOut();

    setState(ViewState.Idle);
    notifyListeners();
  }
}
