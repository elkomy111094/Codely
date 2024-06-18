import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import '../../../shared/generic_cubit/generic_cubit.dart';
import '../../../shared/models/failure.dart';
import '../repositories/registiration_repo.dart';
import '../shared/models/user_model.dart';

class RegisterationViewModel {
  ///Constructor
  /// Called When Creating An Object From This View Moddel == initState
  RegisterationViewModel() {
    FirebaseMessaging.instance.getToken().then((token) {
      deviceToken = token!;
    }).catchError((err) {
      registerationCubit.onErrorState(
          Failure(message: "Failed to get the device token: $err"));
    });
  }

  String deviceToken = "123456";
  RegisterationRepository registerationRepository = RegisterationRepository();

  GenericCubit<dynamic> registerationCubit = GenericCubit(null);
  GlobalKey<FormState> phoneRegisterationFormKey = GlobalKey();
  GlobalKey<FormState> completeRegisterationFormKey = GlobalKey();
  TextEditingController phoneController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  /// Phone Registeration
  bool validatePhoneFormKey() {
    if (phoneRegisterationFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  checkPhone({String? phone}) async {
    if (validatePhoneFormKey()) {
      registerationCubit.onLoadingState();
      try {
        final data = {
          "phone": phone ?? (phoneController.text).toString(),
        };
        await registerationRepository.checkPhone(data: data);
        registerationCubit.onSuccessRequest(null);
      } on Failure catch (failure) {
        registerationCubit.onErrorState(Failure(message: failure.message));
      }
    }
  }

  /// Complete Registeration
  validateCompleteRegisterationFormKey() {
    if (completeRegisterationFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  completeRegisteration() async {
    if (validateCompleteRegisterationFormKey()) {
      registerationCubit.onLoadingState();
      try {
        final data = {
          "first_name": firstNameController.text.toString(),
          "last_name": lastNameController.text.toString(),
          "password": passwordController.text.toString(),
          "email": emailController.text.toString(),
          "devices_token": deviceToken,
          "phone": (phoneController.text).toString(),
        };
        final result =
            await RegisterationRepository().completeRegisteration(data: data);
        registerationCubit.onUpdateData(UserModel.fromJson(result));
        registerationCubit.onSuccessRequest(null);
      } on Failure catch (failure) {
        registerationCubit.onErrorState(Failure(message: failure.message));
      }
    }
  }
}
