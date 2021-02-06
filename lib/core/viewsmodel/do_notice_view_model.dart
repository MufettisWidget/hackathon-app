import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../enum/paged_name.dart';
import 'base_model.dart';

class DoNoticeViewModel extends BaseModel {
  BuildContext _context;
  BuildContext get context => _context;

  DoNoticeViewModel() {}

  goHome() {
    navigator.navigateToRemove(Pages.Home);
  }

  @override
  void setContext(BuildContext context) {
    this._context = context;
  }
}
