import 'package:dio/dio.dart';

import '../shared/models/failure.dart';
import '../shared/network/network.dart';

class RegisterationRepository {
  Future checkPhone({required Map<String, dynamic> data}) async {
    try {
      Response response = await Network.post("check-phone", data: data);
      return response.data;
    } on Failure {
      rethrow;
    }
  }

  Future completeRegisteration({required Map<String, dynamic> data}) async {
    try {
      Response response = await Network.post("register", data: data);
      print(
          "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
      print(response.data.toString());
      return response.data;
    } on Failure {
      rethrow;
    }
  }
}
