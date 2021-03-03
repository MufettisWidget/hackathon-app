import 'package:flutter/material.dart';

import '../../core/viewsmodel/badge_menu_view_model.dart';
import '../../ui/views/baseview.dart';

import '../../shared/style/ui_padding_helper.dart';

class BadgeMenuView extends StatefulWidget {
  @override
  _BadgeMenuViewState createState() => _BadgeMenuViewState();

  BadgeMenuView({
    Key key,
    this.onPress,
  }) : super(key: key);

  final VoidCallback onPress;
}

class _BadgeMenuViewState extends State<BadgeMenuView> {
  // ignore: unused_field
  BadgeMenuViewModel _badgeMenuViewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<BadgeMenuViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        _badgeMenuViewModel = model;
      },
      builder: (context, model, child) {
        return IconButton(
            icon: Icon(
              Icons.menu,
              size: UIPaddingHelper.dynamicHeight(90),
            ),
            onPressed: () {
              widget.onPress();
            });
      },
    );
  }
}
