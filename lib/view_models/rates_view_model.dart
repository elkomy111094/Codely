import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Import the plugin
import 'package:get_time_ago/get_time_ago.dart';
import 'package:smart_shoper_master/models/rate_model.dart';
import 'package:smart_shoper_master/shared/prefs/pref_manager.dart';

import '../../../shared/generic_cubit/generic_cubit.dart';
import '../../../shared/models/failure.dart';
import '../models/cupon_model.dart';
import '../repositories/rates_repo.dart';

class RatesViewModel {
  ///Constructor
  /// Called When Creating An Object From This View Moddel == initState
  RatesViewModel() {
    GetTimeAgo.setDefaultLocale('ar');
  }

  GenericCubit<dynamic> ratesCubit = GenericCubit(null);
  RatesRepository ratesRepository = RatesRepository();
  List<RateModel>? storeRates;
  List<CuponModel>? storeCupons;
  bool ratedBefore = false;
  TextEditingController messageController = TextEditingController();
  double rateVal = 5.0;
  GlobalKey<FormState> ratesFormKey = GlobalKey();

  Future getStoreRates(int storeId) async {
    try {
      storeRates = await ratesRepository.getStoreRates(storeId: storeId);
      ratesCubit.onSuccessRequest(null);
      return storeRates;
    } on Failure catch (failure) {
      ratesCubit.onErrorState(Failure(message: failure.message));
    }
  }

  Future rateStore(int storeId) async {
    ratesCubit.onLoadingState();
    try {
      final data = {
        "rate": rateVal,
        "message": messageController.text,
      };
      await ratesRepository.rateStore(storeId: storeId, data: data);
      ratesCubit.onSuccessRequest(null);
    } on Failure catch (failure) {
      ratesCubit.onErrorState(Failure(message: failure.message));
    }
  }

  checkIfUserRateBefore() {
    storeRates!.forEach((element) {
      if (((element.user.firstName).toString() +
              (element.user.lastName).toString()) ==
          (PrefManager.currentUser!.user.firstName).toString() +
              (PrefManager.currentUser!.user.lastName).toString()) {
        ratedBefore = true;
        ratesCubit.onSuccessRequest(null);
      }
    });
  }

  changeRateVal(double val) {
    rateVal = val;
    ratesCubit.onSuccessRequest(null);
  }

  Future getStoreCupons(int storeId) async {
    try {
      storeCupons = await ratesRepository.getStoreCupons(storeId: storeId);
      ratesCubit.onSuccessRequest(null);
      return storeCupons;
    } on Failure catch (failure) {
      ratesCubit.onErrorState(Failure(message: failure.message));
    }
  }
}
