import 'package:flutter/material.dart';

import '../../shared/style/ui_helper.dart';

class ListGroupItemView extends StatelessWidget {
  const ListGroupItemView({Key key, this.title, this.onPress, this.rightText, this.isDivider, this.dropDownChild}) : super(key: key);
  final String title;
  final String rightText;
  final VoidCallback onPress;
  final bool isDivider;
  final Widget dropDownChild;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Column(
        children: <Widget>[
          Container(
            color: UIHelper.WHITE,
            child: Padding(
              padding: EdgeInsets.only(
                  top: UIHelper.dynamicHeight(dropDownChild != null ? 30 : 60),
                  bottom: UIHelper.dynamicHeight(dropDownChild != null ? 30 : 60),
                  left: UIHelper.dynamicHeight(48),
                  right: UIHelper.dynamicHeight(24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(color: UIHelper.PEAR_PRIMARY_COLOR, fontSize: UIHelper.dynamicScaleSp(44)),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        rightText ?? '',
                        style: TextStyle(color: UIHelper.PEAR_PRIMARY_COLOR, fontSize: UIHelper.dynamicScaleSp(38)),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: UIHelper.PEAR_PRIMARY_COLOR,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          isDivider == null || isDivider
              ? Divider(
                  height: 1,
                  color: UIHelper.PEAR_PRIMARY_COLOR,
                )
              : Container(),
        ],
      ),
    );
  }
}
