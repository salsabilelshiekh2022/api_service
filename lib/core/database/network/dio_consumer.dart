import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmohtaref/core/database/network/end_points.dart';
import 'package:elmohtaref/core/utils/app_constatnts.dart';
import 'package:elmohtaref/core/utils/app_keys.dart';
import 'package:elmohtaref/features/auth/data/models/user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../utils/app_logs.dart';
import '../cache/cache_helper.dart';
import '../cache/cache_services.dart';
import 'app_consumer.dart';

class DioConsumer extends ApiConsumer {
  late final Dio dio;
  final CacheServices cacheServices;

  DioConsumer({required this.dio, required this.cacheServices}) {
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) async {
          String? token = cacheServices
                  .getDataFromCache<UserModel?>(
                    boxName: CacheBoxes.userModelBox,
                    key: 'user',
                  )
                  ?.meta
                  ?.token ??
              '';
          Map<String, String> headers = {
            'Content-Type': 'application/json',
            'accept': 'application/json',
            'lang': EasyLocalization.of(AppKeys.navigatorKey.currentContext!)
                    ?.locale
                    .languageCode ??
                'ar',
            "client-type": Platform.isIOS ? 'ios' : 'android',
            "client-version": getAppVersion,
            "Device-ID": await getDeviceToken() ?? '',
            if (token != '')
              AppConstants.authorizationKey: '${AppConstants.bearerKey} $token',
          };

          options.headers = headers;

          if (kDebugMode) {
            AppLogs.infoLog(options.baseUrl, 'baseUrl From');
            AppLogs.infoLog(options.path, 'endPoint');
            AppLogs.infoLog(options.headers.toString(), 'Headers');
            AppLogs.infoLog(options.data.toString(), 'data');
            AppLogs.infoLog(
                options.queryParameters.toString(), 'queryParameters');
          }
          return handler.next(options);
        },
        onResponse: (Response response, handler) async {
          if (kDebugMode) {
            AppLogs.successLog('${response.data}', 'Response From');
            AppLogs.successLog('${response.statusCode}', 'Response From');
          }
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          if (kDebugMode) {
            AppLogs.errorLog(e.error.toString(), 'dio error response');
            AppLogs.errorLog(e.type.toString(), 'dio error');
            AppLogs.errorLog(e.requestOptions.path, 'dio error');
            AppLogs.errorLog(e.message ?? '', 'dio error message');
            AppLogs.successLog('${e.response?.statusCode}', 'Response From');
          }
          return handler.next(e);
        },
      ),
    );
  }

  @override
  Future get(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    final response = await dio.get(
      path,
      data: data,
      queryParameters: queryParameters,
    );
    return response;
  }

  @override
  Future post({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    //  data["fcm_token"] = await getDeviceToken();
    final response = await dio.post(
      path,
      data: isFromData ? FormData.fromMap(data) : data,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  @override
  Future delete({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    data["fcm_token"] = await getDeviceToken();
    final response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  static void init() {
    Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }
}

String get getAppVersion {
  return AppConstants.appVersion;
}

Future<String?> getDeviceToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  return token;
}
