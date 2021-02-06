import 'package:flutter/material.dart';

import '../../model/notice.dart';
import '../../shared/style/ui_helper.dart';
import 'detail_bottom_view.dart';

class NoticeDetailDialogView extends StatefulWidget {
  @override
  _StationDialogViewState createState() => _StationDialogViewState();

  NoticeDetailDialogView(
      {Key key,
      this.distanceMinute,
      this.currentPointPosition,
      this.noticeDetail,
      this.closeDialog,
      this.mapsRouteCallback,
      this.currentDistancePosition,
      this.mapsCallCallback})
      : super(key: key);

  final String distanceMinute;

  int currentPointPosition;
  int currentDistancePosition;
  final Notice noticeDetail;
  final VoidCallback closeDialog;
  final VoidCallback mapsRouteCallback;
  final VoidCallback mapsCallCallback;
}

class _StationDialogViewState extends State<NoticeDetailDialogView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.closeDialog();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onVerticalDragStart: (c) {
            widget.closeDialog();
          },
          child: InkWell(
            onTap: () {
              widget.closeDialog();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(UIHelper.dynamicHeight(12)),
                  child: SizedBox(
                    height: kToolbarHeight,
                  ),
                ),
                InkWell(
                    onTap: () {},
                    child: Container(
                      color: Colors.black.withAlpha(30),
                      child: Padding(
                        padding: EdgeInsets.only(top: UIHelper.dynamicHeight(40), bottom: UIHelper.dynamicHeight(40)),
                        child: Row(
                          children: <Widget>[
                            Container(),
                          ],
                        ),
                      ),
                    )),
                Spacer(),
                InkWell(
                  onTap: () {},
                  child: MapsBottomModalView(
                    notice: widget.noticeDetail,
                    onRoutePress: () {
                      widget.mapsRouteCallback();
                    },
                    onCallPress: () {
                      widget.mapsCallCallback();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
