import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';
import '../models/failure.dart';
import '../prefs/pref_manager.dart';
import '../providers/language_provider.dart';

class Network {
  static const String baseUrl =
      "https://phplaravel-1200132-4237561.cloudwaysapps.com/api/";
  static final Dio _dio = Dio();

  /// POST Method
  static Future<Response> post(String endPoint,
      {Map<String, dynamic>? data, String? token, String? devicesToken}) async {
    Logger().d(baseUrl + endPoint);
    Logger().d(data);
    try {
      Response response = await _dio.post(
        baseUrl + endPoint,
        data: FormData.fromMap(data!),
        options: token != null
            ? Options(
                headers: {
                  "Authorization": "Bearer " + token,
                  "Content-Type": "application/json",
                  "Accept": "application/json",
                  "Devices-Token": devicesToken ?? "",
                  /* "Accept-Language": Provider.of<LanguageProvider>(
                          navigatorKey.currentContext!,
                          listen: false)
                      .appLanguage,
                  "time-zone": await FlutterTimezone.getLocalTimezone()*/
                },
              )
            : PrefManager.currentUser?.token != null
                ? Options(
                    headers: {
                      "Authorization":
                          "Bearer ${PrefManager.currentUser!.token}",
                      "Content-Type": 'application/json',
                      "Accept": 'application/json',
                      "Devices-Token": devicesToken ?? "",
                    },
                  )
                : Options(
                    headers: {
                      "Content-Type": "application/json",
                      "Accept": "application/json",
                      "Devices-Token": devicesToken ?? "",
                    },
                  ),
      );
      Logger().d(response.data);
      return response;
    } on DioException catch (error) {
      Logger().e(error.message);

      if (error.response?.data != null) {
        List<dynamic> resposeErrors = error.response?.data['errors'] ?? [];
        String message = error.response?.data['message'];
        throw Failure(
            message:
                resposeErrors.isNotEmpty ? resposeErrors[0]["value"] : message,
            data: error.response?.data["errors"]);
      } else if (error.type == DioExceptionType.connectionError ||
          error.type == DioExceptionType.unknown)
        throw Failure(message: "تأكد من الإتصال بالأنترنت", data: [
          {"value": "تأكد من الإتصال بالأنترنت"}
        ]);
      else if (error.type == DioExceptionType.connectionTimeout)
        throw Failure(message: "لقد أنتهت مده الجلسه  ", data: [
          {"value": "لقد أنتهت مده الجلسه"}
        ]);
      else
        throw Failure(message: "Error ${error.message}", data: [
          {"value": "Error ${error.message}"}
        ]);
    } on SocketException {
      Logger().e("Socket Exception");
      throw Failure(message: "No Internet connect", data: [
        {"value": "No Internet connect"}
      ]);
    } on FormatException {
      Logger().e("Format Exception");
      throw Failure(message: "Format Exception", data: [
        {"value": "Format Exception"}
      ]);
    } on Exception catch (e) {
      Logger().e("Unknown Exception");
      throw Failure(message: "Error $e", data: [
        {"value": "Error $e"}
      ]);
    }
  }

  /// POST Method with JSON Data
  static Future postJson(String endPoint, {Map<String, dynamic>? data}) async {
    try {
      return await _dio.post(
        baseUrl + endPoint,
        data: jsonEncode(data),
        options: PrefManager.currentUser!.token != null
            ? Options(
                headers: {
                  "Authorization": "Bearer ${PrefManager.currentUser!.token}",
                  "Content-Type": "application/json",
                  "Accept": "application/json",
                  "Accept-Language": Provider.of<LanguageProvider>(
                          navigatorKey.currentContext!,
                          listen: false)
                      .appLanguage,
                  /* "time-zone": await FlutterTimezone.getLocalTimezone()*/
                },
              )
            : null,
      );
    } on DioError catch (error) {
      if (error.response!.statusCode == 500) {
        throw Failure(message: "Server error", statusCode: 500);
      } else if (error.response!.statusCode == 401) {
        throw Failure(
          message: error.response!.data['errors'] != null
              ? error.response!.data['errors']['MESSAGE']
              : error.response!.data['message'],
          statusCode: 401,
        );
      } else if (error.response!.statusCode == 404) {
        throw Failure(
          message: error.response!.data['errors']['Not Found'],
          statusCode: 404,
        );
      } else if (error.response!.statusCode == 400) {
        throw Failure(
          message: error.response!.data['errors']['MESSAGE'].toString(),
          statusCode: 400,
          data: error.response!.data,
        );
      } else {
        throw Failure(message: error.response!.statusMessage);
      }
    } on SocketException {
      throw Failure(message: "No Internet connect");
    } on FormatException {
      throw Failure(message: "Format Exception");
    } on Error catch (e) {
      throw Failure(message: "Error $e");
    }
  }

  /// Delete Methos
  static Future delete(String endPoint, {Map<String, dynamic>? data}) async {
    try {
      return await _dio.delete(
        baseUrl + endPoint,
        options: PrefManager.currentUser!.token != null
            ? Options(
                headers: {
                  "Authorization": "Bearer ${PrefManager.currentUser!.token}",
                },
              )
            : null,
      );
    } on DioError catch (error) {
      if (error.response!.statusCode == 500) {
        throw Failure(message: "Server error", statusCode: 500);
      } else if (error.response!.statusCode == 401) {
        throw Failure(
          message: error.response!.data['errors'] != null
              ? error.response!.data['errors']['MESSAGE']
              : error.response!.data['message'],
          statusCode: 401,
        );
      } else if (error.response!.statusCode == 404) {
        throw Failure(
          message: error.response!.data['errors']['Not Found'],
          statusCode: 404,
        );
      } else if (error.response!.statusCode == 400) {
        throw Failure(
          message: error.response!.data['errors']['MESSAGE'].toString(),
          statusCode: 400,
          data: error.response!.data,
        );
      } else {
        throw Failure(message: error.response!.statusMessage);
      }
    } on SocketException {
      throw Failure(message: "No Internet connect");
    } on FormatException {
      throw Failure(message: "Format Exception");
    } on Error catch (e) {
      throw Failure(message: "Error $e");
    }
  }

  /// PUT Method
  static Future put(String endPoint, {Map<String, dynamic>? data}) async {
    try {
      return await _dio.put(
        baseUrl + endPoint,
        data: jsonEncode(data),
        options: PrefManager.currentUser!.token != null
            ? Options(
                headers: {
                  "Authorization": "Bearer ${PrefManager.currentUser!.token}",
                  "Content-Type": "multipart/form-data",
                  "Accept": "application/json",
                  "Accept-Language": Provider.of<LanguageProvider>(
                          navigatorKey.currentContext!,
                          listen: false)
                      .appLanguage,
                  /*"time-zone": await FlutterTimezone.getLocalTimezone()*/
                },
              )
            : null,
      );
    } on DioError catch (error) {
      if (error.response!.statusCode == 500) {
        throw Failure(message: "Server error", statusCode: 500);
      } else if (error.response!.statusCode == 401) {
        throw Failure(
            message: error.response!.data['errors'] != null
                ? error.response!.data['errors']['MESSAGE']
                : error.response!.data['message'],
            statusCode: 500);
      } else if (error.response!.statusCode == 404) {
        throw Failure(
          message: error.response!.data['errors']['Not Found'],
          statusCode: 404,
        );
      } else if (error.response!.statusCode == 400) {
        throw Failure(
          message: error.response!.data['errors']['MESSAGE'].toString(),
          statusCode: 400,
        );
      } else {
        throw Failure(message: error.response!.statusMessage);
      }
    } on SocketException {
      throw Failure(message: "No Internet connect");
    } on FormatException {
      throw Failure(message: "Format Exception");
    } on Error catch (e) {
      throw Failure(message: "Error $e");
    }
  }

  /// GET Method
  static Future<Response<dynamic>> get(endPoint,
      {String? token, String? devicesToken}) async {
    Logger().d(baseUrl + endPoint);
    try {
      Response response = await _dio.get(baseUrl + endPoint,
          options: token != null
              ? Options(
                  headers: {
                    "Authorization": "Bearer " + token,
                    "Content-Type": "application/json",
                    "Accept": "application/json",
                    "Devices-Token": devicesToken ?? "",
                    /* "Accept-Language": Provider.of<LanguageProvider>(
                          navigatorKey.currentContext!,
                          listen: false)
                      .appLanguage,
                  "time-zone": await FlutterTimezone.getLocalTimezone()*/
                  },
                )
              : PrefManager.currentUser?.token != null
                  ? Options(
                      headers: {
                        "Authorization":
                            "Bearer ${PrefManager.currentUser!.token}",
                        "Content-Type": 'application/json',
                        "Accept": 'application/json',
                        "Devices-Token": devicesToken ?? "",
                      },
                    )
                  : Options(
                      headers: {
                        "Content-Type": "application/json",
                        "Accept": "application/json",
                        "Devices-Token": devicesToken ?? "",
                      },
                      /*options: PrefManager.currentUser?.token != null
            ? Options(
                headers: {
                  "Authorization":
                      "Bearer ${PrefManager.currentUser!.token}",
                  "Accept": "application/json",
                  "Accept-Language": Provider.of<LanguageProvider>(
                          navigatorKey.currentContext!,
                          listen: false)
                      .appLanguage,
                  "time-zone": await FlutterTimezone.getLocalTimezone(),
                  "Accept-PageSize": 1000,
                },
              )
            : Options(
                headers: {
                  "Accept-Language": Provider.of<LanguageProvider>(
                          navigatorKey.currentContext!,
                          listen: false)
                      .appLanguage,
                  "time-zone": await FlutterTimezone.getLocalTimezone(),
                  "Accept-PageSize": 1000,
                },
              ),*/
                    ));

      Logger().d(response.data);

      return response;
    } on DioError catch (error) {
      Logger().e(error.message);

      if (error.response?.data != null) {
        List<dynamic> resposeErrors = error.response?.data['errors'] ?? [];
        String message = error.response?.data['message'];
        throw Failure(
            message:
                resposeErrors.isNotEmpty ? resposeErrors[0]["value"] : message,
            data: error.response?.data["errors"]);
      } else if (error.type == DioExceptionType.connectionError ||
          error.type == DioExceptionType.unknown)
        throw Failure(message: "تأكد من الإتصال بالأنترنت", data: [
          {"value": "تأكد من الإتصال بالأنترنت"}
        ]);
      else if (error.type == DioExceptionType.connectionTimeout)
        throw Failure(message: "لقد أنتهت مده الجلسه  ", data: [
          {"value": "لقد أنتهت مده الجلسه"}
        ]);
      else
        throw Failure(message: "Error ${error.message}", data: [
          {"value": "Error ${error.message}"}
        ]);
    } on SocketException {
      throw Failure(message: "No Internet connect");
    } on FormatException {
      throw Failure(message: "Format Exception");
    } on Error catch (e) {
      throw Failure(message: "Error $e");
    }
  }

  /// GET URL Method
  static Future<Response<dynamic>> getUrl(endPoint) async {
    Logger().d(endPoint);
    try {
      Response response = await _dio.get(endPoint);

      Logger().d(response.data);

      return response;
    } on DioError catch (error) {
      Logger().d(error.response?.data);
      if (error.response!.statusCode == 500) {
        throw Failure(message: "Server error");
      } else if (error.response!.statusCode == 401) {
        throw Failure(message: "Unauthorized");
      } else if (error.response!.statusCode == 404) {
        throw Failure(message: "Not Found");
      } else if (error.response!.statusCode == 400) {
        throw Failure(message: error.response?.data["message"]);
      } else {
        throw Failure(message: error.response!.statusMessage);
      }
    } on SocketException {
      throw Failure(message: "No Internet connect");
    } on FormatException {
      throw Failure(message: "Format Exception");
    } on Error catch (e) {
      throw Failure(message: "Error $e");
    }
  }
}
