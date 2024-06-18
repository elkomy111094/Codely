import 'package:dio/dio.dart';

import '../../../shared/models/failure.dart';
import '../../../shared/network/network.dart';
import '../models/store_model.dart';

class OffersRepository {
  Future<List<StoreModel>> getStores({required String endPoint}) async {
    try {
      Response response = await Network.get(endPoint);
      List jsonStoresList = response.data["data"];
      return jsonStoresList
          .map((jsonStore) => StoreModel.fromJson(jsonStore))
          .toList();
    } on Failure {
      rethrow;
    }
  }
}
