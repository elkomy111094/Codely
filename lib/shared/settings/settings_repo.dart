import 'package:dio/dio.dart';

import '../models/failure.dart';
import '../network/network.dart';




class SettingsRepo {
  Future getSettings() async {
    try {
      Response response = await Network.get("settings");
      return response.data;
    } on Failure {
      rethrow;
    }
  }
}
