import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';

import '../../../shared/generic_cubit/generic_cubit.dart';
import '../../../shared/models/failure.dart';
import '../../../shared/models/user_model.dart';
import '../repositories/login_repo.dart';

class LoginViewModel {
  ///Constructor
  /// Called When Creating An Object From This View Moddel == initState
  LoginViewModel() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: kgreenColor,
        statusBarColor: kgreenColor,
        statusBarIconBrightness: Brightness.dark));
    FirebaseMessaging.instance.getToken().then((token) {
      deviceToken = token!;
    }).catchError((err) {
      loginCubit.onErrorState(
          Failure(message: "Failed to get the device token: $err"));
    });
  }

  GenericCubit<dynamic> loginCubit = GenericCubit(null);

  GlobalKey<FormState> loginFormKey = GlobalKey();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String deviceToken = "123456";

  bool autheninticated = true;

  LoginRepository loginRepository = LoginRepository();

  String? phoneValidator() {
    // at any time, we can get the text from _controller.value.text
    final text = phoneController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      loginCubit.onUpdateData(null);
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      loginCubit.onUpdateData(null);
      return 'Too short';
    }
    // return null if the text is valid
    return null;
  }

  login() async {
    Logger().d(deviceToken);
    print(deviceToken);
    if (loginFormKey.currentState!.validate() == false) {
      return;
    }
    loginCubit.onLoadingState();
    try {
      final data = {
        "phone": (phoneController.text).toString(),
        "password": passwordController.text.toString(),
        "devices_token": deviceToken
      };
      final result =
          await loginRepository.login(data: data, devicesToken: deviceToken);
      loginCubit.onUpdateData(UserModel.fromJson(result));
      loginCubit.onSuccessRequest(data);
    } on Failure catch (failure) {
      loginCubit.onErrorState(Failure(message: failure.message.toString()));
    }
  }

  Future resetPassword() async {
    loginCubit.onLoadingState();
    try {
      final data = {
        "phone": phoneController.text,
        "password": passwordController.text,
      };
      await loginRepository.resetPassword(data: data);
      loginCubit.onSuccessRequest(null);
    } on Failure catch (failure) {
      loginCubit.onErrorState(Failure(message: failure.message));
    }
  }

  Future getUserData() async {
    try {
      await loginRepository.getUserData();
      loginCubit.onSuccessRequest(null);
    } on Failure catch (failure) {
      loginCubit.onErrorState(Failure(message: failure.message));
    }
  }
}
