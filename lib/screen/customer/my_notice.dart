import '../../core/core_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../../core/viewsmodel/my_notice_view_model.dart';
import '../../model/notice.dart';
import '../../shared/style/ui_helper.dart';
import '../../ui/views/baseview.dart';
import 'my_notice_detail.dart';

class MyNoticeView extends StatefulWidget {
  MyNoticeView({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MyNoticeState();
}

class MyNoticeState extends State<MyNoticeView> {
  MyNoticeViewModel _myNoticeViewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<MyNoticeViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        _myNoticeViewModel = model;
      },
      builder: (context, model, child) {
        return Scaffold(
          body: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: UIHelper.dynamicHeight(100),
                    floating: true,
                    pinned: true,
                    centerTitle: true,
                    title: Container(
                      color: UIHelper.PEAR_PRIMARY_COLOR,
                      padding: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text('Bildirimlerim!'),
                      ),
                    ),
                  ),
                ];
              },
              body: ListView.builder(
                  itemCount: _myNoticeViewModel.noticies.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Card(
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 10),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: RichText(
                                          text: TextSpan(
                                              style: TextStyle(color: UIHelper.PEAR_PRIMARY_COLOR, fontSize: 15.0, fontWeight: FontWeight.bold),
                                              children: [TextSpan(text: 'Bildirilen Birim')]),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: RichText(
                                          text: TextSpan(
                                              style: TextStyle(color: UIHelper.PEAR_PRIMARY_COLOR, fontSize: 15.0, fontWeight: FontWeight.bold),
                                              children: [TextSpan(text: ': ' + _myNoticeViewModel.noticies[index].reportedMunicipality)]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: RichText(
                                          text: TextSpan(
                                              style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                                              children: [TextSpan(text: 'Şehir')]),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: RichText(
                                          text: TextSpan(
                                              style: TextStyle(color: Colors.black, fontSize: 12.0),
                                              children: [TextSpan(text: ': ' + _myNoticeViewModel.noticies[index].city)]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: RichText(
                                          text: TextSpan(
                                              style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                                              children: [TextSpan(text: 'İlce')]),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: RichText(
                                          text: TextSpan(
                                              style: TextStyle(color: Colors.black, fontSize: 12.0),
                                              children: [TextSpan(text: ': ' + _myNoticeViewModel.noticies[index].district)]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: RichText(
                                          text: TextSpan(
                                              style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                                              children: [TextSpan(text: 'Sokak-Cadde ')]),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: RichText(
                                          text: TextSpan(
                                              style: TextStyle(color: Colors.black, fontSize: 12.0),
                                              children: [TextSpan(text: ': ' + _myNoticeViewModel.noticies[index].street)]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: RichText(
                                          text: TextSpan(
                                              style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                                              children: [TextSpan(text: 'No ')]),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: RichText(
                                          text: TextSpan(
                                              style: TextStyle(color: Colors.black, fontSize: 12.0),
                                              children: [TextSpan(text: ': ' + _myNoticeViewModel.noticies[index].streetNo)]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: RichText(
                                          text: TextSpan(
                                              style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                                              children: [TextSpan(text: 'Tarih ')]),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: RichText(
                                          text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0), children: [
                                            TextSpan(text: ': ' + CoreHelper.parseDateData(_myNoticeViewModel.noticies[index].noticeDate))
                                          ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: RichText(
                                          text: TextSpan(
                                              style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                                              children: [TextSpan(text: 'Durumu')]),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: RichText(
                                          text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0), children: [
                                            TextSpan(text: ': ' + CoreHelper.getStatus(_myNoticeViewModel.noticies[index].noticeStatus))
                                          ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  _footerButtonRow(_myNoticeViewModel.noticies[index])
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  })),
        );
      },
    );
  }

  Widget _footerButtonRow(Notice notice) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[_iconLabelButtonEdit(notice), _iconLabelButtonDelete(notice), _iconLabelButtonSuccess(notice)],
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

  Widget _iconLabelDelete(String text) => Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 5,
        children: <Widget>[
          Icon(
            Feather.trash,
            color: CupertinoColors.inactiveGray,
          ),
          Text(text),
          SizedBox(
            width: 10,
          )
        ],
      );

  Widget _iconLabelSuccess(String text, int status) => Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        spacing: 5,
        children: <Widget>[
          Icon(
            Feather.check,
            color: CoreHelper.getColor(status),
          ),
          Text(text),
          SizedBox(
            width: 10,
          )
        ],
      );

  Widget _iconLabelButtonEdit(Notice notice) => InkWell(
        child: _iconLabelEdit('Detay'),
        onTap: () {
          gotoEditNotice(notice);
        },
      );

  Widget _iconLabelButtonDelete(Notice notice) => Visibility(
        child: InkWell(
          child: _iconLabelDelete('Sil'),
          onTap: () {
            _myNoticeViewModel.gotoDelete(notice);
          },
        ),
        visible: (notice.noticeStatus & (64) != 64) && (notice.noticeStatus & (128) != 128),
      );

  Widget _iconLabelButtonSuccess(Notice notice) => InkWell(
        child: _iconLabelSuccess('', notice.noticeStatus),
        onTap: () {
          _myNoticeViewModel.gotoSucces(notice);
        },
      );

  void gotoEditNotice(Notice notice) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => MyNoticeDetail(notice)));
  }
}

class Paint {
  final int id;
  final String title;
  final Color colorpicture;

  Paint(this.id, this.title, this.colorpicture);
}
