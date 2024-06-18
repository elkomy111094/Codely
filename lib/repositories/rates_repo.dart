import 'package:dio/dio.dart';

import '../../../shared/models/failure.dart';
import '../../../shared/network/network.dart';
import '../models/cupon_model.dart';
import '../models/rate_model.dart';

class RatesRepository {
  Future<List<RateModel>> getStoreRates({required int storeId}) async {
    try {
      Response response = await Network.get("stores/$storeId/rates");
      List jsonRates = response.data["data"];
      return jsonRates.map((rate) => RateModel.fromJson(rate)).toList();
    } on Failure {
      rethrow;
    }
  }

  Future<List<CuponModel>> getStoreCupons({required int storeId}) async {
    try {
      Response response = await Network.get("stores/$storeId/coupons");
      List jsonRates = response.data["data"];
      return jsonRates.map((cupon) => CuponModel.fromJson(cupon)).toList();
    } on Failure {
      rethrow;
    }
  }

  Future rateStore(
      {required int storeId, required Map<String, dynamic> data}) async {
    try {
      Response response =
          await Network.post("stores/$storeId/rate", data: data);

      return response.data["data"];
    } on Failure {
      rethrow;
    }
  }
}
