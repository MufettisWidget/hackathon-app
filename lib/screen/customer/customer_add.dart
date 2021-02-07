import 'package:MufettisWidgetApp/core/viewsmodel/customer_add_view_model.dart';
import 'package:MufettisWidgetApp/ui/views/baseview.dart';
import 'package:MufettisWidgetApp/ui/views/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../mixin/validation_mixin.dart';
import '../../model/user.dart';
import '../../shared/style/ui_helper.dart';
import 'customer_login.dart';

class CustomerAddView extends StatefulWidget {
  static const String routeName = "/customerAdd";

  @override
  State<StatefulWidget> createState() => CustomerAddState();
}

class CustomerAddState extends State with ValidationMixin {
  CustomerAddViewModel _customerAddViewModel;
  final formKey = GlobalKey<FormState>();
  final customer = new User("", "", "", "");
  bool isKvkk = false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance.init(context);
    return BaseView<CustomerAddViewModel>(onModelReady: (model) {
      model.setContext(context);
      _customerAddViewModel = model;
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
                  _signup,
                  _getkvkk(),
                  link(),
                  _loginButton,
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget get _signup => Align(
        alignment: Alignment.centerRight,
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: SizedBox(
              height: 30,
              child: FlatButton(
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(50.0)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_context) => CustomerLogin()));
                },
                child: Text(UIHelper.haveAnAccount, style: TextStyle(fontSize: 15, color: Colors.white)),
              ),
            )),
      );

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
                _textFieldPassword(UIHelper.password, true),
              ],
            ),
          ),
        ),
      );

  Widget _textFielCustomeName(String text, bool obscure) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.left,
          keyboardType: TextInputType.text,
          autocorrect: false,
          validator: validateFirtsName,
          onSaved: (String value) {
            customer.nameSurname = value;
          },
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
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.left,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          validator: validateEmail,
          onSaved: (String value) {
            customer.mailAddress = value;
          },
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
          keyboardType: TextInputType.phone,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.left,
          autocorrect: false,
          maxLength: 10,
          validator: validatePhone,
          onSaved: (String value) {
            customer.phone = value;
          },
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

  Widget _textFieldPassword(String text, bool obscure) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.left,
          obscureText: obscure,
          autocorrect: false,
          validator: validatePassword,
          onSaved: (String value) {
            customer.password = value;
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

  Widget get _description => Text(UIHelper.signUpAccount, style: _helloTextStyle(30));

  Widget get _loginButton => Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: InkWell(
          borderRadius: loginButtonBorderStyle,
          onTap: () {
            if (formKey.currentState.validate()) {
              if (isKvkk) {
                formKey.currentState.save();
                customer.isKvkk = true;
                _customerAddViewModel.saveCustomer(customer);
              } else {
                _customerAddViewModel.showDialogkVkk("Kvkk Onaylamaniz Gerekmektedir", true);
              }
            }
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: loginButtonBorderStyle),
            height: UIHelper.dynamicHeight(200),
            width: UIHelper.dynamicWidth(1000),
            child: Center(
              child: Text(
                UIHelper.signUp,
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

  Widget emailNameField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(labelText: "E-Mail", hintText: "mail@mail.com"),
      validator: validateEmail,
      onSaved: (String value) {
        customer.mailAddress = value;
      },
    );
  }

  Widget _getkvkk() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: CheckboxListTile(
        onChanged: (a) {
          setState(() {
            isKvkk = !isKvkk;
          });
        },
        value: isKvkk,
        controlAffinity: ListTileControlAffinity.leading,
        checkColor: Colors.red,
        title: Text(
          "Bildireyim Bunu tarafından kişişel verilerimin işlenmesini ve ticari elektronik ileti almayı kabul ederek açık rıza veriyorum.",
          style: TextStyle(color: Colors.white, fontSize: 12.0),
        ),
      ),
    );
  }

  Widget link() {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: InkWell(
          onTap: () {
            _customerAddViewModel.showDialogKvkk();
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Aydınlatma metni için tıklayınız.",
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.red, decoration: TextDecoration.underline, fontSize: 15.0),
            ),
          ),
        ));
  }

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

 
}
