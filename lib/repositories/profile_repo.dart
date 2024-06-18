import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../shared/models/failure.dart';
import '../../../shared/network/network.dart';

class ProfileRepository {
  Future updateName({Map<String, dynamic>? data}) async {
    try {
      Response response = await Network.post("profile", data: data);
      return response.data;
    } on Failure {
      rethrow;
    }
  }

  Future updateEmail({Map<String, dynamic>? data}) async {
    try {
      Response response = await Network.post("change-email", data: data);
      return response.data;
    } on Failure {
      rethrow;
    }
  }

  Future updatePassword({Map<String, dynamic>? data}) async {
    try {
      Response response = await Network.post("change-password", data: data);
      return response.data;
    } on Failure {
      rethrow;
    }
  }

  Future logOut() async {
    try {
      Response response = await Network.get("logout");
      Logger().d(response.data);
      return response.data;
    } on Failure {
      rethrow;
    }
  }

  Future getUserData() async {
    try {
      Response response = await Network.get("profile");
      Logger().d(response.data);
      return response.data;
    } on Failure {
      rethrow;
    }
  }
}
