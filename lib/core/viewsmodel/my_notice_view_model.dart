import 'dart:convert';

import 'package:flutter/material.dart';

import '../../apis/notice/notice_api.dart';
import '../../model/notice.dart';
import '../../model/reponseModel/reponseNotice.dart';
import '../enum/paged_name.dart';
import '../shared_prefernces_api.dart';
import 'base_model.dart';
import 'main_view_model.dart';

class MyNoticeViewModel extends BaseModel {
  final mynoticeScaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_myNoticeScaffoldKey');

  BuildContext _context;

  BuildContext get context => _context;

  List<Notice> noticies;

  MyNoticeViewModel() {
    getNoticeData(0);
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  void getNoticeData(int page) {
    if (SharedManager().loginRequest.noticies != null) {
      noticies = SharedManager().loginRequest.noticies;
    } else {
      NoticeApiServices.instance.getmyNotice(SharedManager().loginRequest.id).then((response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> map = jsonDecode(response.body);
          var responseNotice = ResponseNotice.fromJson(map);
          noticies = responseNotice.notices;
        }
      });
    }
  }

  Future openLeftDrawer() async => MainViewModel.openLeftMenu();

  void gotoSucces(Notice notice) async {
    if (notice.noticeStatus & 128 != 128) {
      _showDialog('Bildirimi durumu DÜZELDİ olarak güncellenecektir.Tekrar güncellenemez.', notice, false);
    }
  }

  void gotoDelete(Notice notice) {
    _showDialog('Bildirim Silinecek Onaylıyormusunuz ?', notice, true);
  }

  void _showDialog(String txt, Notice notice, bool isDeleted) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bildiri'),
          content: Text(txt),
          actions: <Widget>[
            FlatButton(
              child: Text('Onayla'),
              onPressed: () {
                if (isDeleted) {
                  NoticeApiServices.instance.updateNoticeDelete(notice).then((response) {
                    if (response.statusCode == 204) {
                      NoticeApiServices.instance.getmyNotice(SharedManager().loginRequest.id).then((response) {
                        if (response.statusCode == 200) {
                          Map<String, dynamic> map = jsonDecode(response.body);
                          var responseNotice = ResponseNotice.fromJson(map);

                          var userLogin = SharedManager().loginRequest;

                          userLogin.noticies = <Notice>[];
                          userLogin.noticies = responseNotice.notices;
                          SharedManager().loginRequest = userLogin;

                          navigator.navigateToRemove(Pages.MyNotice);
                        } else {}
                      });
                    }
                  });
                } else {
                  NoticeApiServices.instance.updateNoticeSuccess(notice).then((response) {
                    if (response.statusCode == 204) {
                      NoticeApiServices.instance.getmyNotice(SharedManager().loginRequest.id).then((response) {
                        if (response.statusCode == 200) {
                          Map<String, dynamic> map = jsonDecode(response.body);
                          var responseNotice = ResponseNotice.fromJson(map);

                          var userLogin = SharedManager().loginRequest;

                          userLogin.noticies = <Notice>[];
                          userLogin.noticies = responseNotice.notices;
                          SharedManager().loginRequest = userLogin;

                          navigator.navigateToRemove(Pages.MyNotice);
                        } else {}
                      });
                    }
                  });
                }
              },
            ),
            FlatButton(
              child: Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
