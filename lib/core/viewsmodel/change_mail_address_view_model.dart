import 'dart:convert';

import 'package:MufettisWidgetApp/apis/account/acoount_api.dart';
import 'package:MufettisWidgetApp/core/enum/viewstate.dart';
import 'package:MufettisWidgetApp/model/user.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../shared_prefernces_api.dart';
import 'base_model.dart';

// E-posta adresini değiştirmek için kullan model
class ChangeMailAddressViewModel extends BaseModel {
  final changeMailAddressScaffoldKey = GlobalKey<ScaffoldState>(debugLabel: "_changeMailAddressScaffoldKey");

  BuildContext _context;

  BuildContext get context => _context;

  ChangeMailAddressViewModel() {}

  @override
  void setContext(BuildContext context) {
    this._context = context;
  }

  Future<void> saveNewEmail(String password, String email) async {
    bool isConncet = false;

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      isConncet = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      isConncet = true;
    }
    if (isConncet) {
      AccountApiServices.changeMailAddress(SharedManager().loginRequest.id, password, email).then((response) {
        setState(ViewState.Busy);
        if (response.statusCode == 200) {
          Map userMap = jsonDecode(response.body);
          var userLogin = User.fromJson(userMap);
          userLogin.userToken = SharedManager().jwtToken;
          userLogin.noticies = SharedManager().loginRequest.noticies;

          SharedManager().loginRequest = userLogin;

          _showDialog("E-Posta Adreso Değiştirilmiştir.");
          setState(ViewState.Idle);
        } else {
          _showDialog("Mevcut şifre yanlıştır.");
          setState(ViewState.Idle);
        }
      });
    } else {
      _showDialog("Lütfen internet bağlantınızı kontrol ediniz.");
    }
  }

  void _showDialog(String contextText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Bildiri"),
          content: new Text(contextText),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Kapat"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/myAccount");
              },
            ),
          ],
        );
      },
    );
  }
}
