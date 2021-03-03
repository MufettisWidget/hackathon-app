import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import '../../apis/account/acoount_api.dart';
import '../../apis/notice/notice_api.dart';
import '../../model/notice.dart';
import '../../model/reponseModel/reponseNotice.dart';
import '../../model/user.dart';
import '../enum/paged_name.dart';
import '../enum/viewstate.dart';
import '../shared_prefernces_api.dart';
import 'base_model.dart';

class CustomerLoginViewModel extends BaseModel {
  final noticeScaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_customerLoginScaffoldKey');

  BuildContext _context;

  BuildContext get context => _context;

  CustomerLoginViewModel();

  void setContext(BuildContext context) {
    _context = context;
  }

  Future<void> saveCustomer(User user) async {
    if (state == ViewState.Busy) {
      return;
    } else {
      var isConncet = false;

      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        isConncet = true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        isConncet = true;
      }
      if (isConncet) {
        setState(ViewState.Busy);
        await AccountApiServices.loginUser(user.mailAddress, user.password).then((response) {
          if (response.statusCode == 200) {
            Map userMap = jsonDecode(response.body);
            var userLogin = User.fromJson(userMap);
            SharedManager().jwtToken = userLogin.userToken;

            NoticeApiServices.instance.getmyNotice(userLogin.id).then((response) {
              if (response.statusCode == 200) {
                Map<String, dynamic> map = jsonDecode(response.body);
                var responseNotice = ResponseNotice.fromJson(map);
                userLogin.noticies = <Notice>[];
                userLogin.noticies = responseNotice.notices;
                SharedManager().loginRequest = userLogin;

                navigator.navigateToRemove(Pages.Home);
                setState(ViewState.Idle);
              } else {
                setState(ViewState.Idle);

                SharedManager().loginRequest = userLogin;
              }
            });
          } else {
            _showDialog('Yanlış E-posta yada Şifre');
            setState(ViewState.Idle);
          }
        });
      } else {
        _showDialog('Lütfen internet bağlantınızı kontrol ediniz.');
      }
    }
  }

  void _showDialog(String contextText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bildiri'),
          content: Text(contextText),
          actions: <Widget>[
            FlatButton(
              child: Text('Kapat'),
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
