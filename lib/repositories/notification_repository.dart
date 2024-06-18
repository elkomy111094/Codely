import 'package:dio/dio.dart';

import '../models/notification_model.dart';
import '../shared/models/failure.dart';
import '../shared/network/network.dart';

class NotificationRepository {
  Future<List<NotificationModel>> getNotificationsList() async {
    try {
      Response response = await Network.get("profile/notification");
      List jsonNotificationsList = response.data["data"];
      return jsonNotificationsList
          .map((jsonNotification) =>
              NotificationModel.fromJson(jsonNotification))
          .toList();
    } on Failure {
      rethrow;
    }
  }

  Future deleteNote({required int noteId}) async {
    try {
      Response response = await Network.delete("profile/notification/$noteId");
    } on Failure {
      rethrow;
    }
  }
}
