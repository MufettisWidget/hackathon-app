import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpaceView extends StatelessWidget {
  const SpaceView({Key key, this.height, this.width}) : super(key: key);
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: ScreenUtil.instance.setHeight(height ?? 15), width: ScreenUtil.instance.setHeight(width ?? 15));
  }
}
