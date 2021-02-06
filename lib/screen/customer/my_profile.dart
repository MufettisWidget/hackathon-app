import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/shared_prefernces_api.dart';
import '../../shared/style/ui_helper.dart';
import '../../ui/widget/list_group_item_widget.dart';
import '../../ui/widget/nothc_widget.dart';
import 'change_mail_addressl.dart';
import 'change_password.dart';
import 'my_notice.dart';
import 'my_profile_info.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  // ProfileViewModel _profileViewModel;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance.init(context);
    // return BaseView<ProfileViewModel>(
    //   onModelReady: (model) {
    //     model.setContext(context);
    //     _profileViewModel = model;
    //   },
    //   builder: (context, model, child) {
    return Scaffold(
      backgroundColor: UIHelper.PEAR_PRIMARY_COLOR,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: UIHelper.dynamicHeight(810),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/default_user_image.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 0),
                        child: Container(
                            decoration: BoxDecoration(
                          gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [
                            UIHelper.PEAR_PRIMARY_COLOR,
                            UIHelper.WHITE,
                          ]),
                        )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: kToolbarHeight,
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: UIHelper.dynamicHeight(48)),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed('/');
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  showModalBottom();
                                },
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage("assets/images/default_user_image.png"),
                                    backgroundColor: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(UIHelper.dynamicHeight(24)),
                              child: Text(
                                SharedManager().loginRequest.nameSurname,
                                // SharedManager().loginRequest.nameSurname,
                                style: TextStyle(color: UIHelper.WHITE, fontSize: UIHelper.dynamicScaleSp(54), fontWeight: FontWeight.bold),
                              ),
                            ),
                            // InkWell(
                            //   onTap: () {
                            //     showModalBottom();
                            //   },
                            //   child: Text(
                            //     " Değiştir",
                            //     style: TextStyle(
                            //       color: UIHelper.WHITE,
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: UIHelper.dynamicHeight(20),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(UIHelper.dynamicHeight(36)),
                  child: Container(
                      child: Column(children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: UIHelper.dynamicScaleSp(72),
                      ),
                      title: Align(
                        child: Text(
                          "Hesap Bilgileri",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: UIHelper.dynamicScaleSp(72)),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        ListGroupItemView(
                          title: "Üye Bilgilerim",
                          onPress: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfileInfo()));
                          },
                        ),
                        ListGroupItemView(
                          title: "Şifre Değiştir",
                          onPress: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword()));
                          },
                        ),
                        ListGroupItemView(
                          title: "E-Posta Değiştir",
                          onPress: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeMailAddress()));
                          },
                        ),
                        ListGroupItemView(
                          title: "Bildirimlerim",
                          onPress: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyNoticeView()));
                          },
                        ),
                      ],
                    )
                  ])),
                )
              ],
            ),
          ),
          // Visibility(
          //     visible: _profileViewModel.state == ViewState.Busy ? true : false,
          //     child: Center(child: CircularProgressIndicator()))
        ],
      ),
    );
    //   },
    // );
  }

  Future showModalBottom() async {
    // _profileViewModel.menuItemsFilled();
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.all(UIHelper.Space0),
            child: Container(
                decoration: BoxDecoration(
                  color: UIHelper.PEAR_PRIMARY_COLOR,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(UIHelper.Space15),
                    topRight: Radius.circular(UIHelper.Space15),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    UIHelper.verticalSpaceSmall(),
                    NothcWidget(),
                    // _listMenuItems,
                  ],
                )),
          ),
        );
      },
    );
  }
}
