import '../../core/viewsmodel/my_profile_info_view_model.dart';
import '../../ui/views/baseview.dart';
import '../../ui/views/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/shared_prefernces_api.dart';
import '../../mixin/validation_mixin.dart';
import '../../model/user.dart';
import '../../shared/style/ui_helper.dart';

class MyProfileInfo extends StatefulWidget {
  static const String routeName = '/myAccount';

  @override
  State<StatefulWidget> createState() => MyProfileInfoState();
}

class MyProfileInfoState extends State with ValidationMixin {
  MyProfileInfoViewModel _myProfileInfoViewModel;
  final formKey = GlobalKey<FormState>();

  TextEditingController userName = TextEditingController();
  TextEditingController usermail = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  String newPassword = '';
  String newPasswordAgain = '';

  User user = User('', '', '', '');
  @override
  Widget build(BuildContext context) {
    getCustomerDetail();
    ScreenUtil.instance.init(context);
    return BaseView<MyProfileInfoViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        _myProfileInfoViewModel = model;
      },
      builder: (context, model, child) {
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
      },
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
                _textFielCustomeName(
                  UIHelper.nameSurname,
                  false,
                ),
                _textFieldEmail(
                  UIHelper.email,
                  false,
                ),
                _textFieldPhone(UIHelper.phone, true),
              ],
            ),
          ),
        ),
      );

  Widget _textFielCustomeName(String text, bool obscure) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: TextFormField(
          controller: userName,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.left,
          keyboardType: TextInputType.text,
          obscureText: obscure,
          autocorrect: false,
          validator: validateFirtsName,
          autofocus: false,
          cursorColor: Colors.white,
          maxLines: 1,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: Icon(Icons.account_circle),
                color: Colors.white,
                onPressed: () {},
              ),
            ),
            hintText: text,
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
      );

  Widget _textFieldEmail(String text, bool obscure) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: TextFormField(
          controller: usermail,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.left,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          readOnly: true,
          validator: validateEmail,
          onSaved: (String value) {},
          cursorColor: Colors.white,
          maxLines: 1,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: Icon(Icons.email),
                color: Colors.white,
                onPressed: () {},
              ),
            ),
            hintText: text,
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
      );

  Widget _textFieldPhone(String text, bool obscure) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: TextFormField(
          controller: userPhone,
          keyboardType: TextInputType.phone,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.left,
          readOnly: true,
          autocorrect: false,
          maxLength: 10,
          validator: validatePhone,
          onSaved: (String value) {},
          cursorColor: Colors.white,
          maxLines: 1,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: Icon(Icons.phone),
                color: Colors.white,
                onPressed: () {},
              ),
            ),
            hintText: text,
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
      );

  Widget get _description => Text(UIHelper.changeInfoStatus, style: _helloTextStyle(30));

  Widget get _loginButton => Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: InkWell(
          borderRadius: loginButtonBorderStyle,
          onTap: () {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();
              _myProfileInfoViewModel.updateProfilInfo(userName.text);
            }
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: loginButtonBorderStyle),
            height: UIHelper.dynamicHeight(200),
            width: UIHelper.dynamicWidth(1000),
            child: Center(
              child: Text(
                'Güncelle',
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

  Widget get _helloText => Text(UIHelper.customInfo, style: _helloTextStyle(70));

  Widget passwordNameField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(labelText: 'Şifre', hintText: 'Şifre'),
    );
  }

  TextStyle _helloTextStyle(double fontSize) => TextStyle(
        color: Colors.white,
        fontSize: UIHelper.dynamicSp(fontSize),
        fontWeight: FontWeight.bold,
      );

  // ignore: always_declare_return_types
  getCustomerDetail() async {
    if (SharedManager().loginRequest != null) {
      user = SharedManager().loginRequest;

      userName.text = user.nameSurname;
      usermail.text = user.mailAddress;
      userPhone.text = user.phone;
    } else {
      var _token = SharedManager().jwtToken;
      if (_token != null) {}
    }
  }
}
