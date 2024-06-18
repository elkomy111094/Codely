import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../shared/network/network.dart';
import '../../../shared/prefs/pref_manager.dart';
import '../../../shared/util/app_routes.dart';
import '../../../shared/util/ui.dart';
import '../shared/models/failure.dart';

Future<bool?> checkTokenWork() async {
  if (PrefManager.currentUser != null) {
    Logger().d(
        "////////////////////////////////// Search ////////////////////////////////////");
    try {
      var dio = Dio();
      Response response = await Network.get(
        "profile",
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Failure {
      return false;
    }
  }
}

Future getSplashNextScreen() async {
  bool? tokenState = await checkTokenWork();
  Future.delayed(const Duration(seconds: 3), () async {
    if (await PrefManager.getOnBoardingShowState() == false) {
      UI.pushWithRemove(AppRoutes.introductionView);
    } else if (PrefManager.currentUser == null) {
      //
      UI.pushWithRemove(AppRoutes.authView);
    } else {
      if (tokenState ?? false) {
        UI.pushWithRemove(AppRoutes.landingView);
      } else {
        UI.pushWithRemove(AppRoutes.authView);
      }
    }
  });
}
