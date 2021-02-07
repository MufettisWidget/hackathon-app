import 'dart:convert';

import 'package:MufettisWidgetApp/apis/account/acoount_api.dart';
import 'package:MufettisWidgetApp/core/enum/viewstate.dart';
import 'package:MufettisWidgetApp/model/user.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../shared_prefernces_api.dart';
import 'base_model.dart';

// Kameradan alınan resim için kullanılan model
class CameraNoticeViewModel extends BaseModel {
  final changeMailAddressScaffoldKey = GlobalKey<ScaffoldState>(debugLabel: "_cameraNoticeScaffoldKey");

  BuildContext _context;

  BuildContext get context => _context;

  CameraNoticeViewModel() {}

  void setContext(BuildContext context) {
    this._context = context;
  }
}
