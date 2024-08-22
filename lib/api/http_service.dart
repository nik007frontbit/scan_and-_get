import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:scan_and_get_images/src/core/utils/custom_exception.dart';

class HttpService {
  // dev url
  // static const baseUrl = "https://dev-api.evitalrx.in/v1/whitelabel/";
  // static const baseEvitalUrl = "https://dev.evital.in/v3/rest/";

  //live url
  static const baseUrl = "https://38f3-182-70-125-130.ngrok-free.app/";

  // static const baseEvitalUrl = "https://evital.in/v3/rest/";

  //local url
  // static const baseUrl = "http://192.168.29.236:4444/v1/whitelabel/";
  // static const baseEvitalUrl = "https://dev.evital.in/v3/rest/";

  late Dio _dio;

  HttpService({String baseUrl = baseUrl}) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: const Duration(seconds: 60),
      // 15 seconds
      connectTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
    ));

    initializeInterceptors();
  }

  Future<Response> postRequest(
      {required String endPoint, required dynamic map}) async {
    Response response;

    try {
      response = await _dio.post(
        endPoint,
        data: map,
      );
      return response;
    } on DioException catch (e) {
      log("message ${e}");
      if (e.message == "" || e.message == null) {
        throw CustomException(
            "Something Wrong Try Again later...");
      } else {
        throw CustomException(
            e.message ?? "Something Wrong Try Again later...");
      }
    } catch (e) {
      throw CustomException(e.toString() ?? "");
    }
  }

  Future<Response> get(String endPoint, dynamic map) async {
    Response response;

    try {
      response = await _dio.get(endPoint,
          data: map,
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioException catch (e) {
      log(e.message.toString());
      throw Exception(e.message ?? "");
    }
    return response;
  }

  initializeInterceptors() {
    // _dio.interceptors.add(InterceptorsWrapper(onResponse: (response, handler) {
    //   log("resp=>${jsonEncode(response.data)}");
    //   return handler.next(response); // conti
    // }, onRequest: (options, handler) {
    //   print("${options.uri}\n${options.data}");
    //
    //   if (options.data is FormData) {
    //     var data = options.data as FormData;
    //     print("${data.fields}\n\n");
    //     // print("${data.files}\n\n");
    //   }
    //   return handler.next(options); //continue
    // }, onError: (error, handler) {
    //   print(error.message);
    //   return handler.next(error); //continue
    // }));
    _dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      responseBody: true,
      error: true,
      compact: true,
      request: true,
      requestHeader: true,
      responseHeader: true,
    ));
  }
}
