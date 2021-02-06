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
                      _buildListTile("Bildirim Yap", Icons.add_comment, context, SharedManager().loginRequest == null ? Pages.Login : Pages.DoNotice,
                          isBagde: true),
                      _buildListTile(
                          "Bildirimlerim", Icons.notification_important, context, SharedManager().loginRequest == null ? Pages.Login : Pages.MyNotice,
                          isBagde: true),
                      // _buildListTile(
                      //     "Mutlu Haber Vereyim",
                      //     Icons.add_comment,
                      //     context,
                      //     SharedManager().token == null
                      //         ? Pages.Login
                      //         : Pages.AddHapptNews,
                      //     isBagde: _leftDrawerViewModel
                      //                 .sharedManager.notificationCount ==
                      //             0
                      //         ? false
                      //         : true),
                      // _buildListTile(
                      //     "Mutlu Haberlerim",
                      //     Icons.comment_outlined,
                      //     context,
                      //     SharedManager().token == null
                      //         ? Pages.Login
                      //         : Pages.Home,
                      //     isBagde: _leftDrawerViewModel
                      //                 .sharedManager.notificationCount ==
                      //             0
                      //         ? false
                      //         : true),

                      // _buildListTile(
                      //     _leftDrawerViewModel.translate(
                      //         context, LanguageConstants().news),
                      //     Icons.receipt,
                      //     context,
                      //     Pages.News),

                      Visibility(
                        visible: SharedManager().loginRequest != null,
                        child: _buildListTile('Hesabım', Icons.account_circle, context, Pages.MyAccount),
                      ),

                      Visibility(
                        visible: SharedManager().loginRequest == null,
                        child: _buildListTile("Giriş Yap", Icons.login, context, Pages.Login),
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
                      // _buildListTile(
                      //     _leftDrawerViewModel.translate(
                      //         context, LanguageConstants().faq),
                      //     Icons.question_answer,
                      //     context,
                      //     Pages.Home),
                      // _buildListTile(
                      //     _leftDrawerViewModel.translate(context,
                      //         LanguageConstants().suggestionAndComplaint),
                      //     Icons.support_agent,
                      //     context,
                      //     Pages.Home),

                      // _buildListTile(
                      //     _leftDrawerViewModel.translate(
                      //         context, LanguageConstants().contact),
                      //     Icons.comment_sharp,
                      //     context,
                      //     Pages.Home),
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
                          "assets/icons/appicon.png",
                          scale: 6,
                        ),
                        // Row(
                        //   children: <Widget>[
                        //     Padding(
                        //       padding: EdgeInsets.all(UIHelper.dynamicHeight(24)),
                        //       child: Icon(
                        //         Icons.phone,
                        //         size: 16,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //     InkWell(
                        //       onTap: () {
                        //         CoreHelper.launchCaller(Constants.PHONE_NUMBER);
                        //       },
                        //       child: Text(
                        //         Constants.PHONE_NUMBER,
                        //         style: TextStyle(color: Colors.white),
                        //       ),
                        //     )
                        //   ],
                        // )
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

  Widget get _drawerUserContent {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: () {
              _leftDrawerViewModel.navigator.pop();
              _leftDrawerViewModel.navigateLeftMenu(SharedManager().loginRequest != null ? Pages.Profile : Pages.Login);
            },
            child: AspectRatio(
              aspectRatio: 1,
              child: CircleAvatar(
                backgroundImage: _leftDrawerViewModel.customerDetail == null || _leftDrawerViewModel.customerDetail.nameSurname == null
                    ? AssetImage("assets/images/default_user_image.png")
                    : Image.network(_leftDrawerViewModel.customerDetail.nameSurname).image,
              ),
            ),
          ),
        ),
        SizedBox(
          height: UIHelper.dynamicHeight(12),
        ),
        Visibility(
          visible: _leftDrawerViewModel.customerDetail == null ? false : true,
          child: Text(_leftDrawerViewModel.customerDetail == null ? "" : "${_leftDrawerViewModel.customerDetail.nameSurname} ",
              style: TextStyle(
                fontFamily: 'GothamNarrow',
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              )),
        ),
        SizedBox(
          height: UIHelper.dynamicHeight(12),
        ),
        InkWell(
          onTap: () {
            _leftDrawerViewModel.navigator.pop();
            _leftDrawerViewModel.navigateLeftMenu(SharedManager().loginRequest != null ? Pages.Profile : Pages.Login);
          },
          child: new Text(_leftDrawerViewModel.customerDetail == null ? "Login" : "Register",
              style: TextStyle(
                fontFamily: 'GothamNarrow',
                color: Color(0xff888888),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              )),
        )
      ],
    );
  }

  ListTile _buildListTile(String _title, IconData _icon, BuildContext context, Pages _page, {bool isBagde = false}) {
    return ListTile(
      // trailing: Text("left_dirver_buildListTile"),
      leading: Icon(
        _icon,
        color: Colors.grey,
      ),
      title: new Text(_title,
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
          // widget.onChangeTokenStatus();
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
