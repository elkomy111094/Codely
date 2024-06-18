import 'package:flutter/material.dart';
import 'package:smart_shoper_master/view_models/home_view_model.dart';
import 'package:smart_shoper_master/views/Authentication/views/forget_password_view.dart';
import 'package:smart_shoper_master/views/Notifications/pages/notificationScreen.dart';
import 'package:smart_shoper_master/views/OnBoarding/views/introduction_view.dart';
import 'package:smart_shoper_master/views/landing_view.dart';

import '../../views/Authentication/views/auth_view.dart';
import '../../views/Authentication/views/location_view.dart';
import '../../views/Authentication/views/phone_verification_view.dart';
import '../../views/Authentication/views/subscription_view.dart';
import '../../views/Authentication/views/user_info.dart';
import '../../views/Drawer/views/change_email_view.dart';
import '../../views/Drawer/views/change_name_view.dart';
import '../../views/Drawer/views/change_password_view.dart';
import '../../views/Favorite/views/favorite_view.dart';
import '../../views/Home/views/home_view.dart';
import '../../views/Home/views/search_resualts_view.dart';
import '../../views/Offers/views/offer_details.dart';
import '../../views/Offers/views/offers_view.dart';
import '../../views/Settings/views/settings_page_view.dart';
import '../../views/Settings/views/settings_view.dart';
import '../../views/Stores/views/stores_view.dart';
import '../../views/categories/views/categories_view.dart';
import '../../views/splash_screen.dart';

class AppRoutes {
  // All app routes
  static const String splashView = "splashPage";
  static const String landingView = "landingView";
  static const String introductionView = "introductionView";
  static const String authView = "authView";
  static const String phoneVerificationView = "phoneVerificationView";
  static const String userInfo = "userInfo";
  static const String subscriptionView = "subscriptionView";
  static const String locationView = "locationView";
  static const String homeView = "homeView";
  static const String offersView = "offersView";
  static const String offerDetailsView = "offerDetailsView";
  static const String favoriteView = "favoriteView";
  static const String storesView = "storesView";
  static const String changeNameView = "changeNameView";
  static const String changePasswordView = "changePasswordView";
  static const String changeEmailView = "changeEmailView";
  static const String settingsView = "settingsView";
  static const String searchResultScreen = "searchResultScreen";
  static const String offerDetailsScreen = "offerDetailsScreen";
  static const String settingsPageView = "settingsPageView";
  static const String categoriesView = "categoriesView";
  static const String notificationView = "notificationsView";
  static const String forgetPasswordView = "forgetPasswordView";

  static Route<dynamic> appRoutes(RouteSettings settings) {
    dynamic args = settings.arguments;

    switch (settings.name) {
      case landingView:
        return appPage(const Landingview());
      case introductionView:
        return appPage(const IntroductionView());
      case authView:
        return appPage(const AuthView());
      case phoneVerificationView:
        return appPage(PhoneVerificationView(
          registerationViewModel: args,
        ));
      case userInfo:
        return appPage(UserInfo(
          registerationViewModel: args,
        ));
      case subscriptionView:
        return appPage(const SubscriptionView());
      case notificationView:
        return appPage(NotificationScreen(
          notificationViewModel: args,
        ));
      case locationView:
        return appPage(const LocationView());
      case homeView:
        return appPage(HomeView(
          homeViewModel: HomeViewModel(),
          favoritesViewModel: args,
        ));
      case offersView:
        return appPage(OffersView(
          favoritesViewModel: args,
          offersViewModel: args,
        ));
      case favoriteView:
        return appPage(FavoriteView(
          favoritesViewModel: args,
        ));
      case storesView:
        return appPage(StoresView(
          favoritesViewModel: args,
          storesViewModel: args,
        ));
      case changeNameView:
        return appPage(ChangeNameView());
      case changePasswordView:
        return appPage(const ChangePasswordView());
      case changeEmailView:
        return appPage(const ChangeEmailView());
      case settingsView:
        return appPage(SettingsView());
      case forgetPasswordView:
        return appPage(ForgetPasswordView());
      case categoriesView:
        return appPage(CategoriesView(
          favoritesViewModel: args[0],
          categoryModel: args[1],
        ));
      case searchResultScreen:
        return appPage(SearchResualtScreen(
          homeViewModel: args[0],
          favoritesViewModel: args[1],
        ));
      case offerDetailsScreen:
        return appPage(
            OfferDetailsView(store: args[0], favoritesViewModel: args[1]));
      case settingsPageView:
        return appPage(SettingsPageView(
          page: args,
        ));
      default:
        return appPage(SplashScreen());
    }
  }

  static appPage(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
