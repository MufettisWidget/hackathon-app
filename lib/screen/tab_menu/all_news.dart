import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/viewsmodel/news_view_model.dart';
import '../../model/news.dart';
import '../../shared/style/ui_helper.dart';
import '../../ui/views/baseview.dart';
import '../home/badge_menu.dart';
import 'news_detail.dart';

class AllNewsView extends StatefulWidget {
  State<StatefulWidget> createState() => AllNewsState();
}

int count = 0;

class AllNewsState extends State {
  NewsViewModel _newsViewModel;
  // List<News> news;
  @override
  Widget build(BuildContext context) {
    return BaseView<NewsViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        _newsViewModel = model;
      },
      builder: (context, model, child) {
        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  leading: BadgeMenuView(
                    onPress: () {
                      _newsViewModel.openLeftDrawer();
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
                      child: Text('Haberler'),
                    ),
                  ),
                ),
              ];
            },
            body: ListView.builder(
              itemCount: _newsViewModel.news.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  height: 100,
                  width: double.maxFinite,
                  child: Card(
                    elevation: 5,
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.all(7),
                        child: Stack(children: <Widget>[
                          Align(
                            alignment: Alignment.centerRight,
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(left: 10, top: 5),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(_newsViewModel.news[index].title),
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(_newsViewModel.news[index].newsMunicipality),
                                            //   _footerButtonRow(news[index]),
                                          ],
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          )
                        ]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _footerButtonRow(News notice) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _iconLabelButtonEdit(notice),
          // _iconLabelButtonDelete(notice),
          // _iconLabelButtonSuccess(notice)
        ],
      );

  Widget _iconLabelEdit(String text) => Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        spacing: 5,
        children: <Widget>[
          Icon(
            Icons.arrow_right_alt_outlined,
            color: CupertinoColors.inactiveGray,
          ),
          Text(text),
          SizedBox(
            width: 10,
          )
        ],
      );

  Widget _iconLabelButtonEdit(News notice) => InkWell(
        child: _iconLabelEdit("Detay"),
        onTap: () {
          gotoEditNotice(notice);
        },
      );

  // Widget _iconLabelButtonDelete(Notice notice) => Visibility(
  //       child: InkWell(
  //         child: _iconLabelDelete("Sil"),
  //         onTap: () {
  //           gotoDelete(notice);
  //         },
  //       ),
  //       visible: (notice.noticeStatus & (64) != 64) &&
  //           (notice.noticeStatus & (128) != 128),
  //     );

  // Widget _iconLabelButtonSuccess(Notice notice) => InkWell(
  //       child: _iconLabelSuccess("", notice.noticeStatus),
  //       onTap: () {
  //         gotoSucces(notice);
  //       },
  //     );

  // String getStatus(int status) {
  //   if (status & 1 == 1) return "İşlem Bekliyor";
  //   if (status & 8 == 8) return "İl Belediyesine Atandı.";
  //   if (status & 16 == 16) return "İlçe Belediyesine Atandı.";
  //   if (status & 64 == 64)
  //     return "Belediye tarafından bildirim düzeltildi. Kontrol bekliyor.";
  //   if (status & 128 == 128) return "Kullanıcı tarafından onaylandı";
  //   if (status & 256 == 256)
  //     return "Belediye tarafından Sorun giderildi. Editör Onayladı.";
  // }

  // ignore: missing_return
  Color getColor(status) {
    if ((status & (64) == 64) || (status & (128) == 128))
      return Colors.red;
    else
      return CupertinoColors.systemGrey;
  }

  void gotoEditNotice(News news) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetail(news)));
  }
}

String parseDateData(String dateData) {
  DateFormat formater = new DateFormat('yyy-MM-dd hh:mm');
  return formater.format(DateTime.parse(dateData));
}

class Paint {
  final int id;
  final String title;
  final Color colorpicture;

  Paint(this.id, this.title, this.colorpicture);
}
