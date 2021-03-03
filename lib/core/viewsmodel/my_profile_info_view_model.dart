import '../../apis/account/acoount_api.dart';
import '../enum/viewstate.dart';
import 'base_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../shared_prefernces_api.dart';

class MyProfileInfoViewModel extends BaseModel {
  final myProfileInfoViewModel = GlobalKey<ScaffoldState>(debugLabel: '_myProfileInfoViewModel');

  BuildContext _context;

  BuildContext get context => _context;

  // ignore: empty_constructor_bodies
  MyProfileInfoViewModel() {}

  void setContext(BuildContext context) {
    _context = context;
  }

  // ignore: missing_return
  bool updateProfilInfo(String nameSurname) {
    var updateuser = SharedManager().loginRequest;
    updateuser.nameSurname = nameSurname;
    setState(ViewState.Busy);
    AccountApiServices.updateUser(updateuser).then((response) {
      if (response.statusCode == 204) {
        SharedManager().loginRequest = updateuser;
        setState(ViewState.Idle);
        return true;
      } else {
        return false;
      }
    });
  }
}
