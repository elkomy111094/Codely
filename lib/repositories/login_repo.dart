import 'package:dio/dio.dart';

import '../../../shared/models/failure.dart';
import '../../../shared/network/network.dart';

class LoginRepository {
  Future login({Map<String, dynamic>? data, String? devicesToken}) async {
    try {
      Response response =
          await Network.post("login", data: data, devicesToken: devicesToken);
      return response.data;
    } on Failure {
      rethrow;
    }
  }

  Future resetPassword({Map<String, dynamic>? data}) async {
    try {
      Response response = await Network.post("reset-password", data: data);
      return response.data;
    } on Failure {
      rethrow;
    }
  }

  Future getUserData() async {
    try {
      Response response = await Network.get("profile");
      return response.data;
    } on Failure {
      rethrow;
    }
  }
}
