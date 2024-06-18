import 'package:dio/dio.dart';

import '../../../shared/models/failure.dart';
import '../../../shared/network/network.dart';
import '../models/store_model.dart';

class CategoriesRepository {
  Future<List<StoreModel>> getStores({required int catId}) async {
    try {
      Response response = await Network.get("categories/$catId");
      List jsonStoresList = response.data["data"];
      return jsonStoresList
          .map((jsonStore) => StoreModel.fromJson(jsonStore))
          .toList();
    } on Failure {
      rethrow;
    }
  }
}
