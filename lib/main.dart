import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';

import 'core/services/navigation_service.dart';
import 'core/shared_prefernces_api.dart';
import 'locator.dart';
import 'screen/router.dart' as rt;
import 'shared/style/ui_helper.dart';

String get baseUrl => "https://apis.bildireyimbunu.com/";
//String get baseUrl => "http://localhost:5010/";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _applicationConfigure();

  CameraDescription firstCamera;
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  firstCamera = cameras.first;

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(BildireyimBunu());
}

class BildireyimBunu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildMaterialApp;
  }

  Widget get _buildMaterialApp {
    return MaterialApp(
      title: 'Bildireyim Bunu',
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: rt.Router.generateRoute,
      theme: ThemeData(
        platform: TargetPlatform.android,
        primaryColor: UIHelper.PEAR_PRIMARY_COLOR,
        accentColor: Colors.grey,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        fontFamily: "Lato",
      ),
    );
  }
}
//

Future _applicationConfigure() async {
  initLocator();
  await FlutterConfig.loadEnvVariables();
  await SharedManager().initInstance();
}
