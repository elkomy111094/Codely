import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

import '../../../shared/generic_cubit/generic_cubit.dart';
import '../../../shared/models/failure.dart';
import '../repositories/forget_password_repo.dart';

class ResetPPasswordViewModel {
  ///Constructor
  /// Called When Creating An Object From This View Moddel == initState
  ResetPPasswordViewModel() {
    // do when Create New Object From This ViewModel
  }

  GenericCubit<dynamic> resetPasswordCubit = GenericCubit(null);
  GlobalKey<FormState> phoneResetPasswordFormKey = GlobalKey();
  GlobalKey<FormState> resetPasswordFormKey = GlobalKey();

  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String otp = "";

  /// Phone Registeration
  bool validatePhoneFormKey() {
    if (phoneResetPasswordFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool validateResetFormKey() {
    if (resetPasswordFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  sendOTPToResetPassword({String? phone}) async {
    if (validatePhoneFormKey()) {
      resetPasswordCubit.onLoadingState();
      try {
        final data = {
          "phone": phone ?? "+966" + phoneController.text,
        };
        otp = await ResetPasswordRepository()
            .resetForPhoneNumber(data: data)
            .then((value) {
          return value["otp"].toString();
        });
        Logger().d(otp);

        resetPasswordCubit.onUpdateData(null);
      } on Failure catch (failure) {
        resetPasswordCubit.onErrorState(Failure(message: failure.message));
      }
    }
  }

  resetPassword({String? phone}) async {
    if (validateResetFormKey()) {
      resetPasswordCubit.onLoadingState();
      try {
        final data = {
          "phone": phone ?? "+966" + phoneController.text,
          "otp": otp,
          "password": passwordController.text,
        };
        await ResetPasswordRepository().resetPassword(data: data);

        resetPasswordCubit.onSuccessRequest(null);
      } on Failure catch (failure) {
        resetPasswordCubit.onErrorState(Failure(message: failure.message));
      }
    }
  }
}
