import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'base_model.dart';

class MyNoticeDetailViewModel extends BaseModel {
  final myNoticeDetailViewModel = GlobalKey<ScaffoldState>(debugLabel: '_myNoticeDetailViewModel');

  BuildContext _context;

  BuildContext get context => _context;

  // ignore: empty_constructor_bodies
  MyNoticeDetailViewModel() {}

  void setContext(BuildContext context) {
    _context = context;
  }
}
