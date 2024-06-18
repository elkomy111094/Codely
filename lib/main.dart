import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';
import 'package:smart_shoper_master/shared/prefs/pref_manager.dart';
import 'package:smart_shoper_master/shared/translations/codegen_loader.g.dart';
import 'package:smart_shoper_master/shared/util/app_routes.dart';

import 'firebase_options.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PrefManager.init();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(
            EasyLocalization(
              path: 'assets/translations/',
              supportedLocales: const [
                Locale('ar'),
                Locale('en'),
              ],
              startLocale: const Locale('ar'),
              assetLoader: const CodegenLoader(),
              fallbackLocale: const Locale('ar'),
              child: const MyApp(),
            ),
          ));
  await EasyLocalization.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: []); //enable fullscreen
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (_, child) => MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'Smart shoper',
        theme: ThemeData(
          splashColor: kgreenColor,
          hintColor: kGreyColor,
          backgroundColor: kLightGreyColor,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green,
            accentColor: kgreenColor,
          ).copyWith(
            secondary: Colors.white,
            primary: kBlueColor,
          ),
        ),
        onGenerateRoute: AppRoutes.appRoutes,
        initialRoute: AppRoutes.splashView,
        navigatorKey: navigatorKey,
      ),
    );
  }
}
