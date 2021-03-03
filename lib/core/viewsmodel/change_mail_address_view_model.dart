import 'dart:convert';

import '../../apis/account/acoount_api.dart';
import '../enum/viewstate.dart';
import '../../model/user.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../shared_prefernces_api.dart';
import 'base_model.dart';

// E-posta adresini değiştirmek için kullan model
class ChangeMailAddressViewModel extends BaseModel {
  final changeMailAddressScaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_changeMailAddressScaffoldKey');

  BuildContext _context;

  BuildContext get context => _context;

  // ignore: empty_constructor_bodies
  ChangeMailAddressViewModel() {}

  void setContext(BuildContext context) {
    _context = context;
  }

  Future<void> saveNewEmail(String password, String email) async {
    var isConncet = false;

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      isConncet = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      isConncet = true;
    }
    if (isConncet) {
      await AccountApiServices.changeMailAddress(SharedManager().loginRequest.id, password, email).then((response) {
        setState(ViewState.Busy);
        if (response.statusCode == 200) {
          Map userMap = jsonDecode(response.body);
          var userLogin = User.fromJson(userMap);
          userLogin.userToken = SharedManager().jwtToken;
          userLogin.noticies = SharedManager().loginRequest.noticies;

          SharedManager().loginRequest = userLogin;

          _showDialog('E-Posta Adresi Değiştirilmiştir.');
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
