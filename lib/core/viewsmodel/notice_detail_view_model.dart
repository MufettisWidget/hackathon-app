
import 'package:MufettisWidgetApp/core/viewsmodel/base_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoticeDetailViewModel extends BaseModel {
  final noticeDetailScaffoldKey = GlobalKey<ScaffoldState>(debugLabel: "_noticeDetailScaffoldKey");

  BuildContext _context;

  BuildContext get context => _context;

  NoticeDetailViewModel() {}


  @override
  void setContext(BuildContext context) {
    this._context = context;
  }


}

