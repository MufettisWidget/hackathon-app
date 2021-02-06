import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ui/widget/spaceView.dart';

class UIPaddingHelper {
  // Vertical spacing constants. Adjust to your liking.
  static const double _VerticalSpaceSmall = 10.0;
  static const double _VerticalSpaceMedium = 20.0;
  static const double _VerticalSpaceLarge = 60.0;
  static const double _VerticalSpaceXLarge = 120.0;

  // Vertical spacing constants. Adjust to your liking.
  static const double _HorizontalSpaceSmall = 10.0;
  static const double _HorizontalSpaceMedium = 20.0;
  static const double HorizontalSpaceLarge = 60.0;

  static const double ONBOARD_PAGE_COUNT = 4;
  static const int ONBOARD_NEXT_DURATION = 1000;

  static double dynamicHeight(double val) => ScreenUtil.instance.setHeight(val);

  static double dynamicWidth(double val) => ScreenUtil.instance.setWidth(val);

  static double dynamicSp(double val) => ScreenUtil.instance.setSp(val);

  static double dynamicScaleSp(double val) => ScreenUtil(allowFontScaling: true).setSp(val);

  static const double Space5 = 5.0;
  static const double Space10 = 10.0;
  static const double Space15 = 15.0;
  static const double Space20 = 20.0;
  static const double Space25 = 25.0;
  static const double Space30 = 30.0;
  static const double Space40 = 40.0;
  static const double Space45 = 45.0;

  static const double Space50 = 50.0;
  static const double Space55 = 55.0;
  static const double Space60 = 60.0;
  static const double Space72 = 72.0;
  static const double Space100 = 100.0;
  static const double Space120 = 120.0;
  static const double Space150 = 150.0;
  static const double Space200 = 200.0;
  static const double Space250 = 250.0;
  static const double Space275 = 275.0;
  static const double Space300 = 300.0;
  static const double Space350 = 350.0;
  static const double Space400 = 400.0;
  static const double Space450 = 450.0;
  static const double Space500 = 500.0;
  static const double Space600 = 600.0;
  static const double Space700 = 700.0;
  static const double Space750 = 750.0;
  static const double Space800 = 800.0;
  static const double Space1300 = 1300.0;
  static const double Space1500 = 1500.0;
  static const double Space0 = 0;

  //Paddings
  static double get padding4 => 4;

  static double get padding8 => 8;

  static double get padding12 => 12;

  static double get padding16 => 16;

  static double get padding24 => 24;

  static double get padding32 => 32;

  static double get padding48 => 48;

  static double get padding64 => 64;

  static double get padding80 => 80;

  static const double Radius8 = 8;
  static const double Radius10 = 10;
  static const double Radius16 = 16;

  static double get mainPageContentPadding => 50.0;

  static Future<SnackBarClosedReason> showSnackBar(
      {@required GlobalKey<ScaffoldState> key, Widget child, bool isFixed = true, SnackBarAction action, int duration = 2}) {
    key.currentState.hideCurrentSnackBar();
    return key.currentState
        .showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content: child,
          duration: Duration(seconds: duration),
          action: action,
        ))
        .closed;
  }

  /// Returns a vertical space with height set to [_VerticalSpaceSmall]
  static Widget verticalSpaceSmall() {
    return verticalSpace(_VerticalSpaceSmall);
  }

  /// Returns a vertical space with height set to [_VerticalSpaceMedium]
  static Widget verticalSpaceMedium() {
    return verticalSpace(_VerticalSpaceMedium);
  }

  /// Returns a vertical space with height set to [_VerticalSpaceLarge]
  static Widget verticalSpaceLarge() {
    return verticalSpace(_VerticalSpaceLarge);
  }

  /// Returns a vertical space with height set to [_VerticalSpaceXLarge]
  static Widget verticalSpaceXLarge() {
    return verticalSpace(_VerticalSpaceXLarge);
  }

  /// Returns a vertical space equal to the [height] supplied
  static Widget verticalSpace(double height) {
    return SpaceView(height: height);
  }

  /// Returns a vertical space with height set to [_HorizontalSpaceSmall]
  static Widget horizontalSpaceSmall() {
    return horizontalSpace(_HorizontalSpaceSmall);
  }

  /// Returns a vertical space with height set to [_HorizontalSpaceMedium]
  static Widget horizontalSpaceMedium() {
    return horizontalSpace(_HorizontalSpaceMedium);
  }

  /// Returns a vertical space with height set to [HorizontalSpaceLarge]
  static Widget horizontalSpaceLarge() {
    return horizontalSpace(HorizontalSpaceLarge);
  }

  /// Returns a vertical space equal to the [width] supplied
  static Widget horizontalSpace(double width) {
    return SpaceView(width: width);
  }

  static String unMaskedPhone(String _phone) {
    return _phone.replaceAll(new RegExp('[^0-9]'), '');
  }

  // static Scaffold buildScaffoldError(ErrorResponse errorResponse, String title) => Scaffold(
  //       appBar: AppBar(
  //         backgroundColor: pageBackgroundColor,
  //         iconTheme: IconThemeData(color: Colors.black),
  //         title: Text(title),
  //       ),
  //       body: Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: <Widget>[
  //             Icon(
  //               Icons.signal_wifi_off,
  //               size: 35,
  //             ),
  //             UIHelper.verticalSpaceMedium(),
  //             Text(errorResponse.responseDescription, style: TextStyle(fontSize: dynamicScaleSp(Space45))),
  //           ],
  //         ),
  //       ),
  //     );
}
