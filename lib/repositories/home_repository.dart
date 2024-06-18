import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../shared/models/failure.dart';
import '../../../shared/network/network.dart';
import '../models/category_model.dart';
import '../models/slider_model.dart';
import '../models/store_model.dart';

class HomeRepository {
  Future getSliders() async {
    try {
      Response response = await Network.get("home");
      List jsonSliders = response.data["data"]["sliders"];
      Logger().d(jsonSliders);
      return jsonSliders.map((e) => SliderMModel.fromJson(e)).toList();
    } on Failure {
      rethrow;
    }
  }

  Future getHome() async {
    try {
      Response response = await Network.get("home");
      return response.data;
    } on Failure {
      rethrow;
    }
  }

  Future getCategories() async {
    try {
      Response response = await Network.get("home");
      List jsonSliders = response.data["data"]["categories"];
      Logger().d(jsonSliders);
      return jsonSliders.map((e) => CategoryModel.fromJson(e)).toList();
    } on Failure {
      rethrow;
    }
  }

  Future<List<StoreModel>> search({required Map<String, dynamic> data}) async {
    try {
      Response response = await Network.post("search", data: data);
      List jsonSearchedStoresList = response.data["data"];
      return jsonSearchedStoresList
          .map((jsonFilter) => StoreModel.fromJson(jsonFilter))
          .toList();
    } on Failure {
      rethrow;
    }
  }

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
