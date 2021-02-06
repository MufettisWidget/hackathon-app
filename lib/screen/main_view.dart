import 'package:flutter/material.dart';

import '../core/enum/viewstate.dart';
import '../core/viewsmodel/main_view_model.dart';
import '../shared/style/ui_helper.dart';
import '../ui/views/baseview.dart';

class MainView extends StatefulWidget {
  MainView({Key key, Widget widget}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with WidgetsBindingObserver {
  MainViewModel _mainViewModel;

  //2.faz
  @override
  Widget build(BuildContext context) {
    return BaseView<MainViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        _mainViewModel = model;
        WidgetsBinding.instance.addObserver(this);
      },
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          key: MainViewModel.mainScaffoldKey,
          body: Stack(
            children: <Widget>[
              _mainViewModel.bottomBarChildren[_mainViewModel.currentIndex],
              _mainViewModel.state == ViewState.Busy ? Center(child: CircularProgressIndicator()) : Container()
            ],
          ),
          drawer: _mainViewModel.leftDrawerWidget,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: _mainViewModel.currentIndex,
            backgroundColor: UIHelper.PEAR_PRIMARY_COLOR,
            onTap: _mainViewModel.onTabTapped,
            fixedColor: Colors.white,
            items: <BottomNavigationBarItem>[
              _buildBottomNavigationBarItem(Icons.home, "Anasayfa", 28, 0),
              _buildBottomNavigationBarItem(Icons.map, "Harita", 28, 1),
              _buildBottomNavigationBarItem(Icons.add_alert, "Yeni Bildirim", 28, 2),
              _buildBottomNavigationBarItem(Icons.notification_important, "Bildirimler", 28, 3),
              _buildBottomNavigationBarItem(Icons.receipt, "Haberler", 28, 4),
            ],
          ),
        );
      },
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(IconData _icon, String _title, double _size, int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          _icon,
          color: _mainViewModel.currentIndex == index ? Colors.white : Colors.grey,
          size: _size,
        ),
        title: Text(_title));
  }

  @override
  void didUpdateWidget(MainView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Future<bool> didPopRoute() {
    return super.didPopRoute();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    try {
      switch (state) {
        case AppLifecycleState.inactive:
          break;
        case AppLifecycleState.resumed:
          print("resumed:::::::::");
          break;
        case AppLifecycleState.paused:
          print("paused:::::::::");
          break;
        case AppLifecycleState.detached:
          break;
      }
    } catch (e) {
      print("sd");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
