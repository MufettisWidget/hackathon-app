import 'base_model.dart';
import '../../shared/style/ui_helper.dart';
import '../../ui/widget/nothc_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyProfileViewModel extends BaseModel {
  final myProfileViewModel = GlobalKey<ScaffoldState>(debugLabel: '_myProfileViewModel');

  BuildContext _context;

  BuildContext get context => _context;

  MyProfileViewModel();

  void setContext(BuildContext context) {
    _context = context;
  }

  Future showModalBottom() async {
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
                  ],
                )),
          ),
        );
      },
    );
  }
}
