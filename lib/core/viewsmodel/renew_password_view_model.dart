import 'package:MufettisWidgetApp/core/enum/viewstate.dart';
import 'package:MufettisWidgetApp/screen/customer/customer_login.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import '../../apis/account/acoount_api.dart';
import '../../model/user.dart';
import 'base_model.dart';

class RenewPasswordViewModel extends BaseModel {
  final renewPasswordScaffoldKey = GlobalKey<ScaffoldState>(debugLabel: "_renewPasswordScaffoldKey");

  BuildContext _context;

  BuildContext get context => _context;

  RenewPasswordViewModel() {}

  void setContext(BuildContext context) {
    this._context = context;
  }

  Future<void> saveNewPassword(User user) async {
    bool isConncet = false;

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      isConncet = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      isConncet = true;
    }
    if (isConncet) {
      AccountApiServices.renewPassword(user.id, user.password).then((response) {
        setState(ViewState.Busy);
        if (response.statusCode == 200) {
          setState(ViewState.Idle);
          _showDialog("Şifreniz Değişmiştir. Giriş yapabilirsiniz.", true);
        } else {
          setState(ViewState.Idle);
          _showDialog("E-posta adresine ait kullanıcı bulunamadı.", false);
        }
      });
    } else {
      _showDialog("Lütfen internet bağlantınızı kontrol ediniz.", false);
    }
  }

  void _showDialog(String contextText, bool ischange) {
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
                if (ischange) {
                  Navigator.push(context, MaterialPageRoute(builder: (_context) => CustomerLogin()));
                }
              },
            ),
          ],
        );
      },
    );
  }
}
