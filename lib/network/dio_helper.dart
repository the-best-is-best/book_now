import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'http://192.168.1.4:8080/book_now/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
      options: Options(
          headers: {"Content-Type": "application/json"},
          validateStatus: (_) => true),
    );
  }

  static Future<Response> postData(
      {required String url, required Map<String, dynamic> query}) async {
    return await dio.post(
      url,
      data: query,
      options: Options(
          headers: {"Content-Type": "application/json"},
          validateStatus: (_) => true),
    );
  }

  static Future<Response> putData(
      {required String url, required Map<String, dynamic> query}) async {
    return await dio.put(
      url,
      data: query,
      options: Options(
          headers: {"Content-Type": "application/json"},
          validateStatus: (_) => true),
    );
  }
}
