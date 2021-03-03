import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'base_model.dart';

// Kameradan alınan resim için kullanılan model
class CameraNoticeViewModel extends BaseModel {
  final changeMailAddressScaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_cameraNoticeScaffoldKey');

  BuildContext _context;

  BuildContext get context => _context;

  CameraNoticeViewModel();

  void setContext(BuildContext context) {
    _context = context;
  }
}
