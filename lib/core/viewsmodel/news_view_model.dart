import 'dart:convert';

import 'package:flutter/material.dart';

import '../../apis/news/news_api.dart';
import '../../model/news.dart';
import '../shared_prefernces_api.dart';
import 'base_model.dart';
import 'main_view_model.dart';

class NewsViewModel extends BaseModel {
  final noticeScaffoldKey = GlobalKey<ScaffoldState>(debugLabel: "_newsScaffoldKey");

  BuildContext _context;

  BuildContext get context => _context;

  List<News> news;

  NewsViewModel() {
    getNewsNotice(0);
  }

  @override
  void setContext(BuildContext context) {
    this._context = context;
  }

  void getNewsNotice(int page) {
    if (SharedManager().news != null) {
      news = SharedManager().news;
    } else {
      NewsApiServices.getAllNews().then((response) {
        if (response.statusCode == 200) {
          news = (json.decode(response.body) as List).map((i) => News.fromJson(i)).toList();
          SharedManager().news = news;
        }
      });
    }
  }

  openLeftDrawer() {
    MainViewModel.openLeftMenu();
  }
}
