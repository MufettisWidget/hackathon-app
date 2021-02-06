import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

import '../../model/notice.dart';
import '../../shared/style/ui_helper.dart';
import 'notice_explanation.dart';

Future<void> main(notifi) async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      color: UIHelper.PEAR_PRIMARY_COLOR,

      // theme: ThemeData.dark(),
      home: TakePictureScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera, notice: notifi,
      ),
    ),
  );
}

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;
  final Notice notice;
  //TakePictureScreen(this.camera, this.notice);

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
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );
    notice = widget.notice;

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
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

      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
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
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Construct the path where the image should be saved using the
            // pattern package.
            final path = join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              '${timestamp()}.png',
            );

            // Attempt to take a picture and log where it's been saved.
            await _controller.takePicture(path);

            // If the picture was taken, display it on a new screen.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(path, notice),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}

String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;
  final Notice notice;
  // _CameraExampleHomeState(this.notice);

  DisplayPictureScreen(this.imagePath, this.notice);

  State<StatefulWidget> createState() => DisplayPictureScreenState(this.imagePath, this.notice);
}

class DisplayPictureScreenState extends State {
  String imagePath;
  Notice notice;
  DisplayPictureScreenState(this.imagePath, this.notice);
  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.

    notice = this.notice;

    // Next, initialize the controller. This returns a Future.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UIHelper.PEAR_PRIMARY_COLOR,
        title: Text('Foto NET ise Devam '),
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
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
