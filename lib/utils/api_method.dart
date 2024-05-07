import 'dart:developer';
import 'package:dio/dio.dart';
import '../features/brand/screens/brand_details.dart';

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
      log("Get Api Url=> $url");
      token != null ? headers['Authorization'] = "Bearer $token" : null;
      log("Get Token=> $token");
      Response response =
          await dio.get(url, options: Options(headers: headers));
      log("Response getDio=> $response ${response.data}");

      log("Response Type Get Dio=> ${response.data.runtimeType}");
      if (response.statusCode == 200) {
        log("Get dio Response=> ${response.data}");
        return response.data;
      }
    } on DioException catch (err) {
      log("get statusCode ${err.response?.statusCode.toString()}");
      log("get type ${err.response?.data.toString()} ");
    }
  }

  Future postDioRequest({required Map data}) async {
    try {
      log("post url  $url ");
      log("Post Dio Data $data");
      token != null ? headers['Authorization'] = "Bearer $token" : null;
      log("Post Token=> $token");
      Response response =
          await dio.post(url, data: data, options: Options(headers: headers));

      log("response status ${response.statusCode}");
      log("PostMethod Response=> ${response.data}");

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (err) {
      print("post statusCode ${err.response?.statusCode.toString()}");
      print("post type ${err.response?.data.toString()} ");
    }
  }

  Future putDioRequest({required Map data}) async {
    try {
      log("Put url  $url ");
      log("Put Dio Data $data");
      token != null ? headers['Authorization'] = "Bearer $token" : null;
      log("Put Token=> $token");
      Response response =
          await dio.put(url, data: data, options: Options(headers: headers));

      log("response status ${response.statusCode}");
      log("Put Method Response ${response.data}");

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (err) {
      print("post statusCode ${err.response?.statusCode.toString()}");
      print("post type ${err.response?.data.toString()} ");
    }
  }
}

class ApiUrl {
  static const baseUrl = "https://offers-listing-app-backend.vercel.app";
  static const getUser = "$baseUrl/user";
  static const getBrands = "$baseUrl/brand";
  static const getOffers = "$baseUrl/offer";
  static const sendOtp = "$baseUrl/otp";
  static const verifyOtp = "$baseUrl/otp";
}

Dio dio = Dio();

Future<void> fetchData(void Function(List<dynamic>) fun) async {
  try {
    final response =
        await dio.get("https://offers-listing-app-backend.vercel.app/brand");

    if (response.statusCode == 200) {
      fun(response.data);
    }
  } on DioException catch (err) {
    log(err.toString());
  }
}

Future<void> fetchBrandDetailWithID(void Function(BrandDetail) fun,
    {required String id}) async {
  try {
    final response = await dio
        .get("https://offers-listing-app-backend.vercel.app/brand/$id");
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = response.data;
      log("Response=>>>>${response.data}");
      final BrandDetail brandDetail = BrandDetail.fromJson(responseData);
      fun(brandDetail);
    } else {
      throw Exception('Failed to load data');
    }
  } on DioException catch (err) {
    log(err.toString());
  }
}




// Future<void> fetchDataWithID(void Function(Map<dynamic>) fun,{required String id}) async {
//   final response =
//       await dio.get("${ApiUrl.getUser}$id");

//   if (response.statusCode == 200) {
//     fun(response.data);
//   } else {
//     throw Exception('Failed to load data');
//   }
// }