import 'dart:async';
import 'dart:io';

import '../../core/viewsmodel/camera_notice_view_model.dart';
import '../../ui/views/baseview.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

import '../../model/notice.dart';
import '../../shared/style/ui_helper.dart';
import 'notice_explanation.dart';

Future<void> main(notifi) async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();

  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      color: UIHelper.PEAR_PRIMARY_COLOR,
      home: TakePictureScreen(
        camera: firstCamera,
        notice: notifi,
      ),
    ),
  );
}

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;
  final Notice notice;

  const TakePictureScreen({Key key, @required this.camera, this.notice}) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  Notice notice;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    notice = widget.notice;

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIHelper.PEAR_PRIMARY_COLOR,
      drawerScrimColor: UIHelper.PEAR_PRIMARY_COLOR,
      appBar: AppBar(
        title: Text('Fotografla'),
        backgroundColor: UIHelper.PEAR_PRIMARY_COLOR,
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: UIHelper.PEAR_PRIMARY_COLOR,
        child: Icon(
          Icons.camera_alt,
          color: UIHelper.WHITE,
        ),
        onPressed: () async {
          try {
            await _initializeControllerFuture;

            final path = join(
              (await getTemporaryDirectory()).path,
              '${timestamp()}.png',
            );

            await _controller.takePicture(path);

            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(path, notice),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}

String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;
  final Notice notice;

  DisplayPictureScreen(this.imagePath, this.notice);

  @override
  State<StatefulWidget> createState() => DisplayPictureScreenState(imagePath, notice);
}

class DisplayPictureScreenState extends State {
  // ignore: unused_field
  CameraNoticeViewModel _customerAddViewModel;
  String imagePath;
  Notice notice;
  DisplayPictureScreenState(this.imagePath, this.notice);
  @override
  void initState() {
    super.initState();

    notice = notice;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CameraNoticeViewModel>(onModelReady: (model) {
      model.setContext(context);
      _customerAddViewModel = model;
    }, builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: UIHelper.PEAR_PRIMARY_COLOR,
          title: Text('Doğru fotoğraf mı ?'),
          actions: <Widget>[
            Visibility(
              child: IconButton(
                icon: const Icon(Icons.navigate_next),
                tooltip: 'Kaydet',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_context) => NoticeExplation(notice, imagePath)));
                },
              ),
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: true,
            ),
          ],
        ),
        body: buildImageBody(),
      );
    });
  }

  Widget buildImageBody() {
    return Image.file(
      File(imagePath),
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }
}
