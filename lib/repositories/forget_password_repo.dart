import 'package:dio/dio.dart';

import '../../../shared/models/failure.dart';
import '../../../shared/network/network.dart';

class ResetPasswordRepository {
  Future resetForPhoneNumber({required Map<String, dynamic> data}) async {
    try {
      Response response =
          await Network.post("agent/forget-password", data: data);
      return response.data;
    } on Failure {
      rethrow;
    }
  }

  Future resetPassword({required Map<String, dynamic> data}) async {
    try {
      Response response = await Network.post("agent/new-password", data: data);
      return response.data;
    } on Failure {
      rethrow;
    }
  }
}
