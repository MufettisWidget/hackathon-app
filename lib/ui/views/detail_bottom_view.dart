import 'package:flutter/material.dart';

import '../../main.dart';
import '../../model/notice.dart';
import '../../shared/style/ui_helper.dart';

class MapsBottomModalView extends StatelessWidget {
  final VoidCallback onRoutePress;
  final VoidCallback onCallPress;
  final Notice notice;

  const MapsBottomModalView({
    Key key,
    this.onRoutePress,
    this.onCallPress,
    this.notice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: UIHelper.dynamicHeight(30),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: Padding(
                      padding: EdgeInsets.only(left: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(notice.neighborhood + ' Mahallesi',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: UIHelper.dynamicSp(48),
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              )),
                          SizedBox(
                            height: UIHelper.dynamicHeight(24),
                          ),
                          Text(notice.street + ' ' + notice.streetNo,
                              style: TextStyle(
                                color: Color(0xff454749),
                                fontSize: UIHelper.dynamicSp(32),
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                              )),
                          SizedBox(
                            height: UIHelper.dynamicHeight(40),
                          ),
                          Text(notice.explation,
                              style: TextStyle(
                                color: Color(0xff454749),
                                fontSize: UIHelper.dynamicSp(32),
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                              )),
                          SizedBox(
                            height: UIHelper.dynamicHeight(40),
                          ),
                          Image(
                            height: 150,
                            image: NetworkImage(baseUrl + 'UploadFile/' + notice.photoName + '.jpg'),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: UIHelper.dynamicHeight(30),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding buildStationDetailImage({Widget image}) {
    return Padding(
      padding: EdgeInsets.only(right: UIHelper.dynamicSp(12)),
      child: image,
    );
  }
}
