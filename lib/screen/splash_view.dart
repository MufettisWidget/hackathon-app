import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/viewsmodel/splash_view_model.dart';
import '../shared/style/ui_helper.dart';
import '../ui/views/baseview.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  String _animationName = "bildireyim_bunu_flare";

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance.init(context);
    return BaseView<SplashViewModel>(
      onModelReady: (model) {
        model.setContext(context);
      },
      builder: (context, model, child) {
        return Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: Container(
                padding: EdgeInsets.all(UIHelper.dynamicHeight(100)),
                decoration: new BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    colors: [Colors.white, UIHelper.PEAR_PRIMARY_COLOR],
                    stops: [0, 1],
                  ),
                ),
                child: Center(
                  child: FlareActor(
                    "assets/images/bildireyim_bunu.flr",
                    fit: BoxFit.contain,
                    animation: _animationName,
                  ),
                ),
              )),
        );
      },
    );
  }
}
