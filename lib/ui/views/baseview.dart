import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/viewsmodel/base_model.dart';
import '../../locator.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;

  //init onModelReaedy start on model life cycle
  final Function(T) onModelReady;

  BaseView({@required this.builder, this.onModelReady});

  @override
  _BaseViewState createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> with WidgetsBindingObserver {
  //getit kütüphanesi ile kullandığımız modelilimiz
  T model = locator<T>();

  @override
  void initState() {
    if (ScreenUtil.instance == null) {
      ScreenUtil.instance.init(context);
    }

    if (widget.onModelReady != null) {
      //on model metodu var ise gelen modeli parse diyor
      widget.onModelReady(model);
    }
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(
        builder: widget.builder,
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    try {
      switch (state) {
        case AppLifecycleState.inactive:
          break;
        case AppLifecycleState.resumed:
          print("resumed:::::::::");
          //Adjust.onResume();
          break;
        case AppLifecycleState.paused:
          print("paused:::::::::");
          // Adjust.onPause();
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

/*  @override
  Widget build(BuildContext context) {
    //değişikleri alt childlara uyarıyor
    return ChangeNotifierProvider<T>(
      builder: (context) => model,
      //tüketici viewmodel ondan türeyen modeller ile sayfaya dokunulup işlem yapılabilir
      // getit DI sayesınde A-> B modeli data bind edilebilir değiştireiblir
      child: Consumer<T>(
        builder: widget.builder,
      ),
    );
  }*/

}
