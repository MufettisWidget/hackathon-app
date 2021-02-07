import 'dart:convert';

import 'package:flutter/material.dart';

import '../../apis/notice/notice_api.dart';
import '../../model/notice.dart';
import '../../model/reponseModel/reponseNotice.dart';
import '../shared_prefernces_api.dart';
import 'base_model.dart';
import 'main_view_model.dart';

//Tab menüdeki Tüm bildirimleri görmek için kullanılan model
class AllNoticeViewModel extends BaseModel {
  final noticeScaffoldKey = GlobalKey<ScaffoldState>(debugLabel: "_allnoticeScaffoldKey");

  BuildContext _context;

  BuildContext get context => _context;

  List<Notice> noticies;

  AllNoticeViewModel() {
    getNoticeData(0);
  }

  @override
  void setContext(BuildContext context) {
    this._context = context;
  }

  void getNoticeData(int page) {
    if (SharedManager().openNotice != null) {
      noticies = SharedManager().openNotice;
    } else {
      NoticeApiServices.instance.getAllNoticeNoPage().then((response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> map = jsonDecode(response.body);
          var responseNotice = ResponseNotice.fromJson(map);
          SharedManager().openNotice = responseNotice.notices;
          noticies = responseNotice.notices;
        }
      });
    }
  }

  openLeftDrawer() {
    MainViewModel.openLeftMenu();
  }
}
