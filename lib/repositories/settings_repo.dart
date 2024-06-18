import 'package:dio/dio.dart';
import 'package:smart_shoper_master/models/settings_data_model.dart';

import '../../../shared/models/failure.dart';
import '../shared/network/network.dart';

class SettingsRepository {
  Future<SettingsData> getAppSettings() async {
    try {
      Response response = await Network.get("settings");
      var SettingsDataJson = response.data["data"];
      return SettingsData.fromJson(SettingsDataJson);
    } on Failure {
      rethrow;
    }
  }
}
