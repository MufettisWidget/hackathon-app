import 'dart:convert';

import '../../apis/account/acoount_api.dart';
import '../enum/viewstate.dart';
import '../../model/user.dart';
import '../../screen/customer/renew_password.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'base_model.dart';

class ForgotPasswordViewModel extends BaseModel {
  final forgotPasswordViewModel = GlobalKey<ScaffoldState>(debugLabel: '_forgotPasswordViewModel');

  BuildContext _context;

  BuildContext get context => _context;

  // ignore: always_declare_return_types
  CustomerAddViewModel() {}

  void setContext(BuildContext context) {
    _context = context;
  }

  Future<void> goToRenewPassword(String mailAddres) async {
    var isConncet = false;

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      isConncet = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      isConncet = true;
    }
    if (isConncet) {
      await AccountApiServices.forgotPassword(mailAddres).then((response) {
        setState(ViewState.Busy);
        if (response.statusCode == 200) {
          Map userMap = jsonDecode(response.body);
          var userLogin = User.fromJson(userMap);

          Navigator.push(context, MaterialPageRoute(builder: (_context) => RenewPassword(userLogin)));
          setState(ViewState.Idle);
        } else {
          _showDialog('E-posta adresine ait kullanıcı bulunamadı.');
          setState(ViewState.Idle);
        }
      });
    } else {
      _showDialog('Lütfen internet bağlantınızı kontrol ediniz.');
      setState(ViewState.Idle);
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
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }
}
