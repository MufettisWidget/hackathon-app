import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../enum/paged_name.dart';
import 'base_model.dart';

class DoNoticeViewModel extends BaseModel {
  BuildContext _context;
  BuildContext get context => _context;

  // ignore: empty_constructor_bodies
  DoNoticeViewModel() {}

  Future<Future> goHome() async => navigator.navigateToRemove(Pages.Home);

  void setContext(BuildContext context) {
    _context = context;
  }
}
