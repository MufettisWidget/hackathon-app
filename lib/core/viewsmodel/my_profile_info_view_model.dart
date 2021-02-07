import 'package:MufettisWidgetApp/apis/account/acoount_api.dart';
import 'package:MufettisWidgetApp/core/enum/viewstate.dart';
import 'package:MufettisWidgetApp/core/viewsmodel/base_model.dart';
import 'package:MufettisWidgetApp/model/user.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../shared_prefernces_api.dart';

class MyProfileInfoViewModel extends BaseModel {
  final myProfileInfoViewModel = GlobalKey<ScaffoldState>(debugLabel: "_myProfileInfoViewModel");

  BuildContext _context;

  BuildContext get context => _context;

  MyProfileInfoViewModel() {}

  @override
  void setContext(BuildContext context) {
    this._context = context;
  }

  Future<void> saveNewPassword(String nameSurname) async {
    bool isConncet = false;

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      isConncet = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      isConncet = true;
    }
    if (isConncet) {
      var updateuser = SharedManager().loginRequest;
      updateuser.nameSurname = nameSurname;
      setState(ViewState.Busy);
      AccountApiServices.updateUser(updateuser).then((response) {
        if (response.statusCode == 204) {
          SharedManager().loginRequest = updateuser;
          _showDialog("Bilgileriniz Güncellenmiştir.", true);
          setState(ViewState.Busy);
        } else {
          _showDialog("Hata", false);
          setState(ViewState.Busy);
        }
      });
    } else {
      _showDialog("Lütfen internet bağlantınızı kontrol ediniz.", false);
    }
  }

  void _showDialog(String contextText, bool status) {
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
                if (status) Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/myAccount");
              },
            ),
          ],
        );
      },
    );
  }
}
