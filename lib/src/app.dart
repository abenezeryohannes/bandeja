import 'package:feekpadel/src/main/core/presentations/pages/main.page.dart';
import 'package:feekpadel/src/main/presentation/authentication/page/signup.page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'admin/core/presentations/pages/home.page.admin.dart';
import 'core/langs/locals.dart';
import 'flavors.dart';
import 'owner/core/presentation/pages/home.page.owner.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: FF.title,
      translations: Locals(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      enableLog: kDebugMode,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: const ColorScheme.light(
              background: Colors.white, onBackground: Colors.black)),
      themeMode: ThemeMode.light,
      home: SignupPage(),
    );
  }

  Widget homePage() {
    return _flavorBanner(
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
              home: (FF.appFlavor == Flavor.admin)
                  ? const HomePageAdmin()
                  : (FF.appFlavor == Flavor.owner)
                      ? const HomePageOwner()
                      : const MainPage());
        },
      ),
      show: kDebugMode,
    );
  }

  Widget _flavorBanner({
    required Widget child,
    bool show = true,
  }) =>
      show
          ? Banner(
              location: BannerLocation.topStart,
              message: FF.name,
              color: Colors.green.withOpacity(0.6),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.0,
                  letterSpacing: 1.0),
              textDirection: TextDirection.ltr,
              child: child,
            )
          : Container(
              child: child,
            );
}
