import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../apis/account/acoount_api.dart';
import '../../core/shared_prefernces_api.dart';
import '../../mixin/validation_mixin.dart';
import '../../model/user.dart';
import '../../shared/style/ui_helper.dart';

class ChangePassword extends StatefulWidget {
  static const String routeName = "/changePassword";

  @override
  State<StatefulWidget> createState() => ChangePasswordState();
}

class ChangePasswordState extends State with ValidationMixin {
  final formKey = GlobalKey<FormState>();

  String oldPasswordChange = "";
  String newPassword = "";
  String newPasswordAgain = "";
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance.init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      backgroundColor: UIHelper.PEAR_PRIMARY_COLOR,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _helloText,
                _description,
                _formField,
                _loginButton,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _formField => Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                _textFieldOldPassword(UIHelper.oldPassword, true),
                _textFieldNewPassword(UIHelper.password, true),
                _textFieldNewPasswordAgain(UIHelper.passwordAgain, true),
              ],
            ),
          ),
        ),
      );

  Widget _textFieldNewPassword(String text, bool obscure) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.left,
          obscureText: obscure,
          autocorrect: false,
          validator: validatePassword,
          onSaved: (String value) {
            newPassword = value;
          },
          cursorColor: Colors.white,
          maxLines: 1,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: Icon(Icons.vpn_key),
                color: Colors.white,
                onPressed: () {},
              ),
            ),
            hintText: text,
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
      );

  Widget _textFieldNewPasswordAgain(String text, bool obscure) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.left,
          obscureText: obscure,
          autocorrect: false,
          validator: (val) {
            if (val.isEmpty) return 'Empty';

            return null;
          },
          onSaved: (String value) {
            newPasswordAgain = value;
          },
          cursorColor: Colors.white,
          maxLines: 1,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: Icon(Icons.vpn_key),
                color: Colors.white,
                onPressed: () {},
              ),
            ),
            hintText: text,
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
      );

  Widget _textFieldOldPassword(String text, bool obscure) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.left,
          obscureText: obscure,
          autocorrect: false,
          cursorColor: Colors.white,
          maxLines: 1,
          onSaved: (String value) {
            oldPasswordChange = value;
          },
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: Icon(Icons.vpn_key),
                color: Colors.white,
                onPressed: () {},
              ),
            ),
            hintText: text,
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
      );

  Widget get _description => Text(UIHelper.changPasswprdExplanation, style: _helloTextStyle(30));

  Widget get _loginButton => Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: InkWell(
          borderRadius: _loginButtonBorderStyle,
          onTap: () {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();
              saveNewPassword(oldPasswordChange, newPassword);
            }
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: _loginButtonBorderStyle),
            height: UIHelper.dynamicHeight(200),
            width: UIHelper.dynamicWidth(1000),
            child: Center(
              child: Text(
                UIHelper.goOn,
                style: TextStyle(
                  color: UIHelper.PEAR_PRIMARY_COLOR,
                  fontSize: UIHelper.dynamicSp(40),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      );

  Widget get _helloText => Text(UIHelper.changePassword, style: _helloTextStyle(70));

  Widget passwordNameField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(labelText: "Şifre", hintText: "Şifre"),
    );
  }

  TextStyle _helloTextStyle(double fontSize) => TextStyle(
        color: Colors.white,
        fontSize: UIHelper.dynamicSp(fontSize),
        fontWeight: FontWeight.bold,
      );
  BorderRadius get _loginButtonBorderStyle => BorderRadius.only(
        bottomLeft: Radius.circular(20),
        topLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
        topRight: Radius.circular(20),
      );

  Future<void> saveNewPassword(String oldPassword, String newPassword) async {
    bool isConncet = false;

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      isConncet = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      isConncet = true;
    }
    if (isConncet) {
      AccountApiServices.changePassword(SharedManager().loginRequest.id, oldPassword, newPassword).then((response) {
        setState(() {
          if (response.statusCode == 200) {
            Map userMap = jsonDecode(response.body);
            var userLogin = User.fromJson(userMap);
            userLogin.userToken = SharedManager().jwtToken;
            userLogin.noticies = SharedManager().loginRequest.noticies;

            SharedManager().loginRequest = userLogin;

            _showDialog("Şifre Değiştirilmiştir.");
          } else {
            _showDialog("Mevcut şifre yanlıştır.");
          }
        });
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
