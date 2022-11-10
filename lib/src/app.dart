import 'package:bandeja/src/admin/core/presentations/pages/admin.main.page.dart';
import 'package:bandeja/src/admin/presentation/authentication/pages/admin.landing.page.dart';
import 'package:bandeja/src/app.controller.dart';
import 'package:bandeja/src/core/domain/authentication/entities/user.dart';
import 'package:bandeja/src/core/theme/theme.dart';
import 'package:bandeja/src/owner/core/presentation/pages/owner.main.page.dart';
import 'package:bandeja/src/owner/presentation/authentication/pages/owner.landing.page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'core/langs/locals.dart';
import 'flavors.dart';
import 'main/core/presentations/pages/main.page.dart';
import 'main/presentation/authentication/page/user.landing.page.dart';

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
        theme: BandejaThemeData.Theme(),
        themeMode: ThemeMode.light,
        home: const GuardPage());
  }
}

class GuardPage extends StatefulWidget {
  const GuardPage({Key? key}) : super(key: key);

  @override
  State<GuardPage> createState() => _GuardPageState();
}

class _GuardPageState extends State<GuardPage> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    appController.loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _flavorBanner(
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          // return Obx(() => appController.user.value.when(
          //     emptyState: () =>
          //         SignupPage(onAuthentication: () => appController.loadUser()),
          //     errorState: ((failure) => (failure).runtimeType ==
          //             UnAuthorizedFailure().runtimeType
          //         ? SignupPage(onAuthentication: () => appController.loadUser())
          //         : ShowError(failure: failure)),
          //     loadingState: (_) => SplashScreen(),
          //     loadedState: (value) => (FF.appFlavor == Flavor.admin)
          //         ? const HomePageAdmin()
          //         : (FF.appFlavor == Flavor.owner)
          //             ? const OwnerHomePage()
          //             : const MainPage()));
          return Obx(() => (showAppropriatePage(appController.user.value)));
        },
      ),
      show: kDebugMode,
    );
  }

  Widget showAppropriatePage(UserModel? user) {
    if (FF.appFlavor == Flavor.owner) {
      if (user == null) {
        return const OwnerLandingPage();
      } else {
        GetStorage().write('token', 'owner4');
        return const OwnerMainPage();
      }
    } else if (FF.appFlavor == Flavor.admin) {
      if (user == null) {
        return const AdminLandingPage();
      } else {
        GetStorage().write('token', 'admin7');
        return const AdminMainPage();
      }
    } else {
      if (user == null) {
        return const UserLandingPage();
      } else {
        GetStorage().write('token', 'user');
        return const MainPage();
      }
    }
  }

  Widget SplashScreen() {
    return Image.asset(
      'assets/img/image.png',
      height: Get.height,
      width: Get.width,
      fit: BoxFit.cover,
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
