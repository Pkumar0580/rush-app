import 'dart:developer';
import 'package:dio/dio.dart';

class ApiMethod {
  Dio dio = Dio();
  final String url;
  final String? token;
  final Map? data;

  Map<String, dynamic> headers = {
    'Content-Type': 'application/json; charset=utf-8',
  };

  ApiMethod({required this.url, this.token, this.data});

  Future getDioRequest() async {
    try {
      token != null ? headers['Authorization'] = "Bearer $token" : null;
      Response response =
          await dio.get(url, options: Options(headers: headers));
      log("response get status ${response.statusCode} ${response.data}");
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (err) {
      log(err.response?.data);
    }
    return false;
  }

  Future postDioRequest({dynamic data}) async {
    try {
      token != null ? headers['Authorization'] = "Bearer $token" : null;
      log(headers.toString());
      Response response =
          await dio.post(url, data: data, options: Options(headers: headers));

      log("response status ${response.statusCode}");
      log("response status ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioException catch (err) {
      if (err.response!.statusCode == 403) {}
    }

    return false;
  }
}
