import 'dart:convert';
import 'package:logger/logger.dart';

import '../models/user_model.dart';
import 'pref_keys.dart';
import 'pref_utils.dart';

class PrefManager {
  static bool? isDarkTheme;
  static UserModel? currentUser;

  static Future init() async {
    /// User
    String userData = await getCurrentUserFromSharedPref();
    if (userData.isNotEmpty) {
      Map<String, dynamic> user =
          jsonDecode(await getCurrentUserFromSharedPref());
      currentUser = UserModel.fromJson(user);
      Logger().d("user : ${currentUser!.toJson()}");
    }

    /// Dark theme
    isDarkTheme = await getDarkTheme();
    Logger().d("isDarkTheme $isDarkTheme");
  }

  /// SETTERS
  static Future setCurrentUser(UserModel? user) async {
    currentUser = user;
    if (user != null) {
      String storedUser = jsonEncode(user.toJson());
      await PrefUtils.setString(PrefKeys.currentUser, storedUser).then((value) {
        Logger().d("CurrentUser Saved SuccessFully");
        setOnBoardingShowState(state: true);
      });
      await setCurrentUserAccessTokenInSharedPrefs();
    } else {
      await PrefUtils.setString(PrefKeys.currentUser, "");
    }
  }

  static Future setDarkTheme(bool value) async {
    isDarkTheme = value;
    await PrefUtils.setBool(PrefKeys.kIsDarkTheme, value);
  }

  /// GETTERS
  static Future<String> getCurrentUserFromSharedPref() async {
    return await PrefUtils.getString(PrefKeys.currentUser);
  }

  static Future setCurrentUserAccessTokenInSharedPrefs() async {
    if (currentUser != null) {
      await PrefUtils.setString(
              PrefKeys.userToken, currentUser!.token.toString())
          .then((value) {
        Logger().d("AccessToken Saved SuccessFully");
      });
    } else {
      await PrefUtils.setString(PrefKeys.currentUser, "");
      Logger().d("AccessToken Not Saved Saved , Can't Find User ");
    }
  }

  static Future<String> getUserToken() async {
    return await PrefUtils.getString(PrefKeys.userToken);
  }

  static Future setOnBoardingShowState({bool? state}) async {
    await PrefUtils.setBool("onBoardingState", state ?? false);
  }

  static Future getOnBoardingShowState() async {
    bool? state = await PrefUtils.getBool("onBoardingState");
    Logger().d(state);
    return state;
  }

  static Future<bool> getDarkTheme() async {
    return await PrefUtils.getBool(PrefKeys.kIsDarkTheme);
  }
}
