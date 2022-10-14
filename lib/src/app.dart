import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'admin/core/presentations/pages/home.page.admin.dart';
import 'app.controller.dart';
import 'core/langs/locals.dart';
import 'core/presentation/widgets/show.error.dart';
import 'flavors.dart';
import 'main/core/presentations/pages/main.page.dart';
import 'owner/core/presentation/pages/home.page.owner.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  final AppController controller = Get.put(AppController());
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
      home: Obx(() => controller.user.value.when(
          emptyState: () => const MainPage(),
          loadingState: (_) => const MainPage(),
          loadedState: (_) => const MainPage(),
          errorState: (failure) => ShowError(failure: failure))),
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
