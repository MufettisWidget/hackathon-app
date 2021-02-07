import 'dart:convert';

import 'package:flutter/material.dart';

import '../../apis/news/news_api.dart';
import '../../model/news.dart';
import '../shared_prefernces_api.dart';
import 'base_model.dart';
import 'main_view_model.dart';

class NewDetailViewModel extends BaseModel {
  final newDetailScaffoldKey = GlobalKey<ScaffoldState>(debugLabel: "_newsScaffoldKey");

  BuildContext _context;

  BuildContext get context => _context;

  List<News> news;

  NewDetailViewModel() {}

  @override
  void setContext(BuildContext context) {
    this._context = context;
  }
}
