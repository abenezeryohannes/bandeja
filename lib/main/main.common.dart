import 'package:feekpadel/main/injection/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../src/flavors.dart' as f_f;

import '../src/app.dart';

Future<void> mainCommon() async {
  await preRunApp();
  runApp(const App());
  return FlutterNativeSplash.remove();
}

Future<void> preRunApp() async {
  // Keeps splash screen up until FlutterNativeSplash.remove is called
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );

  // Loads contents from .env into memory.
  await dotenv.load();

  // Locks app orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Makes the device's app bar and bottom navigation bar visible
  // because 'flutter_native_splash.yaml' renders a full screen splash screen,
  // thereby hiding both elements
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );

  //Setting SysemUIOverlay
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: true,
      systemNavigationBarColor: Colors.grey.shade100,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark));

  //Setting SystmeUIMode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);

  // Adds Google Font license in the app's LicenseRegistry.
  // LicenseRegistry.addLicense(() async* {
  //   final license = await rootBundle.loadString('fonts/Montserrat/OFL.txt');
  //   yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  // });

  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  //injections and firebase config ....
  await configureDependencies(f_f.FF.env);
}
