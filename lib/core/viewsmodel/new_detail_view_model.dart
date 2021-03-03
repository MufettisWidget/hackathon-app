import 'package:flutter/material.dart';

import '../../model/news.dart';
import 'base_model.dart';

class NewDetailViewModel extends BaseModel {
  final newDetailScaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_newsScaffoldKey');

  BuildContext _context;

  BuildContext get context => _context;

  List<News> news;

  // ignore: empty_constructor_bodies
  NewDetailViewModel() {}

  void setContext(BuildContext context) {
    _context = context;
  }
}
