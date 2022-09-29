import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: "https://student.valuxapps.com/api/",
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> postData(
      {required String url,
      String lang = "en",
      String? token,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data}) async {
    dio!.options.headers = {
      "lang": lang,
      "Authorization": token,
      'Content-Type': 'application/json'
    };
    return dio!.post(url, queryParameters: query, data: data);
  }

  static Future<Response> getData({
    required String url,
    String lang = "en",
    String? token,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      "lang": lang,
      "Authorization": token,
      'Content-Type': 'application/json'
    };
    return dio!.get(url, queryParameters: query);
  }

  static Future<Response> putData(
      {required String url,
      String lang = "en",
      String? token,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data}) async {
    dio!.options.headers = {
      "lang": lang,
      "Authorization": token,
      'Content-Type': 'application/json'
    };
    return dio!.put(url, queryParameters: query, data: data);
  }
}
