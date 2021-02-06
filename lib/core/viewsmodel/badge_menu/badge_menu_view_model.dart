import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../shared_prefernces_api.dart';
import '../base_model.dart';

class BadgeMenuViewModel extends BaseModel {
  BuildContext _context;

  BuildContext get context => _context;

  SharedManager sharedManager = new SharedManager();

  BadgeMenuViewModel() {}

  @override
  void setContext(BuildContext context) {
    this._context = context;
  }
}
