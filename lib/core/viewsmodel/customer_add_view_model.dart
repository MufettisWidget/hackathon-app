import 'package:MufettisWidgetApp/core/enum/viewstate.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import '../../apis/account/acoount_api.dart';
import '../../model/user.dart';
import 'base_model.dart';

class CustomerAddViewModel extends BaseModel {
  final customerAddScaffoldKey = GlobalKey<ScaffoldState>(debugLabel: "_customerAddScaffoldKey");

  BuildContext _context;

  BuildContext get context => _context;

  CustomerAddViewModel() {}
  @override
  void setContext(BuildContext context) {
    this._context = context;
  }

  Future<void> saveCustomer(User user) async {
    bool isConncet = false;

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      isConncet = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      isConncet = true;
    }
    if (isConncet) {
      AccountApiServices.createUser(user).then((response) {
        setState(ViewState.Busy);
        if (response.statusCode == 201) {
          _showDialog("Kayıdınız alındı. Devamke!", true);
          setState(ViewState.Idle);
        } else {
          _showDialog("Aynı mail adresi veya telefon numarasına ait kayıt vardır.", false);
          setState(ViewState.Idle);
        }
      });
    } else {
      _showDialog("Lütfen internet bağlantınızı kontrol ediniz.", false);
    }
  }

  void _showDialog(String contextText, bool isuscces) {
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
                if (isuscces) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("/login");
                }
              },
            ),
          ],
        );
      },
    );
  }
}
