import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../injector/injection_container.dart' as di;
import '../../../presentation/main/main.dart';
import '../../config/config.dart';
import 'development.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Config().setConfig(config);
  await di.init();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then(
    (_) => runApp(OOTApp()),
  );
}
