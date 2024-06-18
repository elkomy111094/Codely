import 'package:dio/dio.dart';

import '../../../shared/models/failure.dart';
import '../models/store_model.dart';
import '../shared/network/network.dart';

class FavoritesRepository {
  Future<List<StoreModel>> getFavoritesList() async {
    try {
      Response response = await Network.get("store-favorite");
      List jsonStoresList = response.data["data"];
      return jsonStoresList
          .map((jsonStore) => StoreModel.fromJson(jsonStore))
          .toList();
    } on Failure {
      rethrow;
    }
  }

  Future addToFavorites({required int id}) async {
    try {
      Response response = await Network.post("store-favorite/$id", data: {});
    } on Failure {
      rethrow;
    }
  }

  Future deleteFromFavorites({required int id}) async {
    try {
      Response response = await Network.delete("store-favorite/$id");
    } on Failure {
      rethrow;
    }
  }
}
