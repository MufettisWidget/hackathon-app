import 'dart:convert';

import '../../apis/account/acoount_api.dart';
import '../enum/viewstate.dart';
import '../../model/user.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../shared_prefernces_api.dart';
import 'base_model.dart';

//Kullanıcının şifresini değiştirmesi için kullanılan model
class ChangePasswordViewModel extends BaseModel {
  final changePasswordScaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_changePasswordScaffoldKey');

  BuildContext _context;

  BuildContext get context => _context;

  // ignore: empty_constructor_bodies
  ChangePasswordViewModel() {}

  void setContext(BuildContext context) {
    _context = context;
  }

  Future<void> saveNewPassword(String oldPassword, String newPassword) async {
    var isConncet = false;

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      isConncet = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      isConncet = true;
    }
    if (isConncet) {
      await AccountApiServices.changePassword(SharedManager().loginRequest.id, oldPassword, newPassword).then((response) {
        setState(ViewState.Busy);
        if (response.statusCode == 200) {
          Map userMap = jsonDecode(response.body);
          var userLogin = User.fromJson(userMap);
          userLogin.userToken = SharedManager().jwtToken;
          userLogin.noticies = SharedManager().loginRequest.noticies;

          SharedManager().loginRequest = userLogin;

          _showDialog('Şifre Değiştirilmiştir.');
          setState(ViewState.Idle);
        } else {
          _showDialog('Mevcut şifre yanlıştır.');
          setState(ViewState.Idle);
        }
      });
    } else {
      _showDialog('Lütfen internet bağlantınızı kontrol ediniz.');
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
                Navigator.of(context).pushNamed('/myAccount');
              },
            ),
          ],
        );
      },
    );
  }
}
