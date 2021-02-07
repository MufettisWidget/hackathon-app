import 'package:MufettisWidgetApp/core/core_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';

import '../../core/viewsmodel/all_notice_view_model.dart';
import '../../model/notice.dart';
import '../../shared/style/ui_helper.dart';
import '../../ui/views/baseview.dart';
import '../home/badge_menu.dart';
import 'notice_detail.dart';

class AllNoticeView extends StatefulWidget {
  AllNoticeView({Key key}) : super(key: key);
  State<StatefulWidget> createState() => AllNoticeState();
}

class AllNoticeState extends State<AllNoticeView> {
  AllNoticeViewModel _allNoticeViewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<AllNoticeViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        _allNoticeViewModel = model;
      },
      builder: (context, model, child) {
        return Scaffold(
          body: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    leading: BadgeMenuView(
                      onPress: () {
                        _allNoticeViewModel.openLeftDrawer();
                      },
                    ),
                    expandedHeight: UIHelper.dynamicHeight(150),
                    floating: true,
                    pinned: true,
                    centerTitle: true,
                    title: Container(
                      padding: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text('Bildirimler'),
                      ),
                    ),
                  ),
                ];
              },
              body: ListView.builder(
                  itemCount: _allNoticeViewModel.noticies.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 10),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
                                          children: [TextSpan(text: "Bildirilen Birim")]),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(color: UIHelper.PEAR_PRIMARY_COLOR, fontSize: 15.0, fontWeight: FontWeight.bold),
                                          children: [TextSpan(text: ": " + _allNoticeViewModel.noticies[index].reportedMunicipality)]),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                                          children: [TextSpan(text: "Şehir")]),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.black, fontSize: 12.0),
                                          children: [TextSpan(text: ": " + _allNoticeViewModel.noticies[index].city)]),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                                          children: [TextSpan(text: "İlce")]),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.black, fontSize: 12.0),
                                          children: [TextSpan(text: ": " + _allNoticeViewModel.noticies[index].district)]),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                                          children: [TextSpan(text: "Mahalle")]),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.black, fontSize: 12.0),
                                          children: [TextSpan(text: ": " + _allNoticeViewModel.noticies[index].neighborhood)]),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                                          children: [TextSpan(text: "Sokak-Cadde ")]),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.black, fontSize: 12.0),
                                          children: [TextSpan(text: ": " + _allNoticeViewModel.noticies[index].street)]),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                                          children: [TextSpan(text: "No ")]),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.black, fontSize: 12.0),
                                          children: [TextSpan(text: ": " + _allNoticeViewModel.noticies[index].streetNo)]),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                                          children: [TextSpan(text: "Tarih ")]),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: RichText(
                                      text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0), children: [
                                        TextSpan(text: ": " + CoreHelper.parseDateData(_allNoticeViewModel.noticies[index].noticeDate))
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                                          children: [TextSpan(text: "Durumu")]),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.black, fontSize: 12.0),
                                          children: [TextSpan(text: ": " + CoreHelper.getStatus(_allNoticeViewModel.noticies[index].noticeStatus))]),
                                    ),
                                  ),
                                ],
                              ),
                              _footerButtonRow(_allNoticeViewModel.noticies[index])
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
        );
      },
    );
  }

  Widget _footerButtonRow(Notice notice) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _iconLabelButtonEdit(notice),
        ],
      );

  Widget _iconLabelEdit(String text) => Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 5,
        children: <Widget>[
          Icon(
            Feather.info,
            color: CupertinoColors.inactiveGray,
          ),
          Text(text),
          SizedBox(
            width: 10,
          )
        ],
      );

  Widget _iconLabelButtonEdit(Notice notice) => InkWell(
        child: _iconLabelEdit("Detay"),
        onTap: () {
          gotoEditNotice(notice);
        },
      );

  void gotoEditNotice(Notice notice) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => NoticeDetail(notice)));
  }
}

class Paint {
  final int id;
  final String title;
  final Color colorpicture;

  Paint(this.id, this.title, this.colorpicture);
}
