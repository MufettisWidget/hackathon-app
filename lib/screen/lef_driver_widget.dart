import 'package:flutter/material.dart';

import '../core/enum/paged_name.dart';
import '../core/shared_prefernces_api.dart';
import '../core/viewsmodel/lef_drawer_view_model.dart';
import '../shared/style/ui_helper.dart';
import '../ui/views/baseview.dart';
import 'splash_view.dart';

class LeftDrawerWidget extends StatefulWidget {
  final VoidCallback onChangeTokenStatus;
  final VoidCallback returnMain;
  final VoidCallback returnMainConverted;

  const LeftDrawerWidget({Key key, this.onChangeTokenStatus, this.returnMain, this.returnMainConverted}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LeftDrawerState();
  }
}

class LeftDrawerState extends State<LeftDrawerWidget> {
  LeftDrawerViewModel _leftDrawerViewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<LeftDrawerViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        _leftDrawerViewModel = model;
        _leftDrawerViewModel.onChangeTokenStatusModel = widget.onChangeTokenStatus;
        _leftDrawerViewModel.returnMain = widget.returnMain;
        _leftDrawerViewModel.returnMainConverted = widget.returnMainConverted;
      },
      builder: (context, model, child) {
        return Drawer(
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(top: 30),
                    children: <Widget>[
                      _buildListTile('Bildirim Yap', Icons.add_comment, context, SharedManager().loginRequest == null ? Pages.Login : Pages.DoNotice,
                          isBagde: true),
                      _buildListTile(
                          'Bildirimlerim', Icons.notification_important, context, SharedManager().loginRequest == null ? Pages.Login : Pages.MyNotice,
                          isBagde: true),
                      Visibility(
                        visible: SharedManager().loginRequest != null,
                        child: _buildListTile('Hesabım', Icons.account_circle, context, Pages.MyAccount),
                      ),
                      Visibility(
                        visible: SharedManager().loginRequest == null,
                        child: _buildListTile('Giriş Yap', Icons.login, context, Pages.Login),
                      ),
                      Visibility(
                        visible: SharedManager().loginRequest == null,
                        child: _buildListTile('Kayit Ol', Icons.account_box, context, Pages.Signin),
                      ),
                      Visibility(
                        visible: SharedManager().loginRequest != null,
                        child: _buildListTile('Çıkış Yap', Icons.logout, context, null),
                      ),
                      Padding(
                        padding: EdgeInsets.all(UIHelper.dynamicHeight(48)),
                        child: Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Color(0xff0c0d17).withOpacity(0.7),
                  height: UIHelper.dynamicHeight(150),
                  child: Padding(
                    padding: EdgeInsets.all(UIHelper.dynamicHeight(24)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          'assets/icons/appicon.png',
                          scale: 6,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  ListTile _buildListTile(String _title, IconData _icon, BuildContext context, Pages _page, {bool isBagde = false}) {
    return ListTile(
      leading: Icon(
        _icon,
        color: Colors.grey,
      ),
      title: Text(_title,
          style: TextStyle(
            fontFamily: 'Lato',
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
          )),
      dense: true,
      onTap: () {
        if (_page == null) {
          _leftDrawerViewModel.logout();
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => SplashView()));
        } else {
          _leftDrawerViewModel.navigateLeftMenu(_page);
        }
      },
    );
  }
}
