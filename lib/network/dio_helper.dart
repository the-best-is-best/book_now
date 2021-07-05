import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static int() {
    dio = Dio(BaseOptions(
      baseUrl: 'http://localhost/book_now/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData(
      {required String url, required Map<String, dynamic> query}) async {
    return await dio.get(url, queryParameters: query);
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
}
