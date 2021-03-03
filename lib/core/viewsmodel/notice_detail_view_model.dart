import 'base_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoticeDetailViewModel extends BaseModel {
  final noticeDetailScaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_noticeDetailScaffoldKey');

  BuildContext _context;

  BuildContext get context => _context;

  // ignore: empty_constructor_bodies
  NoticeDetailViewModel() {}

  void setContext(BuildContext context) {
    _context = context;
  }
}
