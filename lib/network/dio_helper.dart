import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static late Dio sendMessage;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'http://192.168.1.6/book_now/',
      receiveDataWhenStatusError: true,
    ));

    sendMessage = Dio(BaseOptions(
      baseUrl: 'https://fcm.googleapis.com/fcm/send',
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

  static Future<Response> postNotification() async {
    Map<String, dynamic> query = {
      "to": "/topics/all_users",
      "data": {"listen": "true"}
    };
    return await sendMessage.post(
      "",
      data: query,
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization":
            "key=AAAAqk167YQ:APA91bG-RmEp5m20Wr0k2_2tAbN8Mz0tKHVgbcXUrOVarYGAwamW5uPEUaUUn_yEL4DHDmZ3LeOoEZtQdKhb45ObMfei3ES5i2EoHJK4oiDC4Nmtup5sqsslwtqTh_N-zqinvmChkGmL",
      }, validateStatus: (_) => true),
    );
  }
}
