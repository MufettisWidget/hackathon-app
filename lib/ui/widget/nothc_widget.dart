import 'package:flutter/material.dart';

import '../../shared/style/ui_helper.dart';

class NothcWidget extends StatelessWidget {
  NothcWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(UIHelper.dynamicHeight(50)),
      child: Container(
        width: UIHelper.Space50,
        height: UIHelper.dynamicHeight(12),
        decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.all(Radius.circular(UIHelper.dynamicHeight(36)))),
        alignment: Alignment.center,
      ),
    );
  }
}
