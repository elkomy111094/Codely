import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../shared/generic_cubit/generic_cubit.dart';
import '../../../shared/models/failure.dart';
import '../../../shared/models/user_model.dart';
import '../repositories/profile_repo.dart';
import '../shared/prefs/pref_manager.dart';

class ProfileViewModel {
  ///Constructor
  /// Called When Creating An Object From This View Moddel == initState
  ProfileViewModel() {
    FirebaseMessaging.instance.getToken().then((token) {
      deviceToken = token!;
    }).catchError((err) {
      profileCubit.onErrorState(
          Failure(message: "Failed to get the device token: $err"));
    });
  }

  String deviceToken = "123456";
  File? userImage;

  GenericCubit<dynamic> profileCubit = GenericCubit(null);
  ProfileRepository profileRepository = ProfileRepository();

  GlobalKey<FormState> nameFormKey = GlobalKey<FormState>();

  TextEditingController firstNameController =
      TextEditingController(text: PrefManager.currentUser!.user.firstName);
  TextEditingController lastNameController =
      TextEditingController(text: PrefManager.currentUser!.user.lastName);
  TextEditingController emailController =
      TextEditingController(text: PrefManager.currentUser!.user.email);
  TextEditingController newEmailController = TextEditingController();
  TextEditingController emailPassController = TextEditingController();

  GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future getUserData() async {
    try {
      final user = await profileRepository.getUserData();
      Logger().d(PrefManager.currentUser?.token);
      UserModel updatedUser = UserModel(
          message: user["message"],
          errors: user["errors"],
          token: PrefManager.currentUser!.token,
          user: UserData.fromJson(user["data"]));
      profileCubit.onSuccessRequest(updatedUser);
    } on Failure catch (failure) {
      profileCubit.onErrorState(Failure(message: failure.message));
    }
  }

  Future updateName() async {
    if (nameFormKey.currentState!.validate() == false) {
      return;
    }
    profileCubit.onLoadingState();
    try {
      final data = {
        if (userImage != null)
          "avatar": await MultipartFile.fromFile(userImage!.path,
              filename: userImage!.path.split("/").last),
        "first_name": firstNameController.text.toString(),
        "last_name": lastNameController.text.toString(),
        'devices_token': deviceToken,
      };
      Map<String, dynamic> jsonResponse =
          await profileRepository.updateName(data: data);
      await PrefManager.setCurrentUser(UserModel(
          message: PrefManager.currentUser!.message,
          errors: PrefManager.currentUser!.errors,
          user: UserData.fromJson(jsonResponse["data"]),
          token: PrefManager.currentUser!.token));
      profileCubit.onSuccessRequest(null);
    } on Failure catch (failure) {
      profileCubit.onErrorState(Failure(message: failure.message));
    }
  }

  Future updateEmail() async {
    profileCubit.onLoadingState();
    try {
      final data = {
        "email": newEmailController.text.toString(),
        "password": emailPassController.text.toString(),
      };
      await profileRepository.updateEmail(data: data);
      profileCubit.onUpdateData(null);
    } on Failure catch (failure) {
      profileCubit.onErrorState(Failure(message: failure.message));
    }
  }

  Future updatePassword() async {
    profileCubit.onLoadingState();
    try {
      final data = {
        "old_password": currentPasswordController.text.toString(),
        "password": newPasswordController.text.toString(),
        "password_confirmation": confirmPasswordController.text.toString(),
      };
      await profileRepository.updatePassword(data: data);
      profileCubit.onUpdateData(null);
    } on Failure catch (failure) {
      profileCubit.onErrorState(Failure(message: failure.message));
    }
  }

  Future logOut() async {
    try {
      await profileRepository.logOut();
    } on Failure catch (failure) {
      profileCubit.onErrorState(Failure(message: failure.message));
    }
  }
}
