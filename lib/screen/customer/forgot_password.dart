import '../../core/viewsmodel/forgot_password_view_model.dart';
import '../../ui/views/baseview.dart';
import '../../ui/views/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../mixin/validation_mixin.dart';
import '../../shared/style/ui_helper.dart';

class ForgotPassword extends StatefulWidget {
  static const String routeName = '/forgotPassword';

  @override
  State<StatefulWidget> createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State with ValidationMixin {
  ForgotPasswordViewModel _forgotPasswordViewModel;
  final formKey = GlobalKey<FormState>();
  String mailAddres = '';

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance.init(context);
    return BaseView<ForgotPasswordViewModel>(onModelReady: (model) {
      model.setContext(context);
      _forgotPasswordViewModel = model;
    }, builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        backgroundColor: UIHelper.PEAR_PRIMARY_COLOR,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
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
    });
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
                _textFieldEmail(
                  UIHelper.email,
                  false,
                ),
              ],
            ),
          ),
        ),
      );

  Widget _textFieldEmail(String text, bool obscure) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.left,
          obscureText: obscure,
          autocorrect: false,
          validator: validateEmail,
          cursorColor: Colors.white,
          maxLines: 1,
          onSaved: (String value) {
            mailAddres = value;
          },
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

  Widget get _description => Text(UIHelper.forgatPasswordAccount, style: _helloTextStyle(30));

  Widget get _loginButton => Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: InkWell(
          borderRadius: loginButtonBorderStyle,
          onTap: () {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();
              _forgotPasswordViewModel.goToRenewPassword(mailAddres);
            }
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: loginButtonBorderStyle),
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

  Widget get _helloText => Text(UIHelper.hello, style: _helloTextStyle(70));

  TextStyle _helloTextStyle(double fontSize) => TextStyle(
        color: Colors.white,
        fontSize: UIHelper.dynamicSp(fontSize),
        fontWeight: FontWeight.bold,
      );
}
