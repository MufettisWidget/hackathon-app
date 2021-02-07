import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../enum/paged_name.dart';
import 'base_model.dart';

class SuccesShareViewModel extends BaseModel {
  BuildContext _context;
  BuildContext get context => _context;

  SuccesShareViewModel() {}

  goHome() {
    navigator.navigateToRemove(Pages.Home);
  }

  goNewNotice() {
    navigator.navigateToRemove(Pages.DoNotice);
  }

  void setContext(BuildContext context) {
    this._context = context;
  }
}
