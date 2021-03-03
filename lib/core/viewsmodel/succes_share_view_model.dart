import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../enum/paged_name.dart';
import 'base_model.dart';

class SuccesShareViewModel extends BaseModel {
  BuildContext _context;
  BuildContext get context => _context;

  SuccesShareViewModel();

  Future<Future> goHome() async => navigator.navigateToRemove(Pages.Home);

  Future<Future> goNewNotice() async => navigator.navigateToRemove(Pages.DoNotice);

  void setContext(BuildContext context) {
    _context = context;
  }
}
