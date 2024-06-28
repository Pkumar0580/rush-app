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
    log("Url=========>$url");
    try {
      token != null ? headers['Authorization'] = "$token" : null;
      Response response =
          await dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (err) {
      log("get statusCode ${err.response?.statusCode.toString()}");
      log("get type ${err.response?.data.toString()} ");
    }
  }

  // Future postDioRequest({required Map data}) async {
  //   log("postdata=>>$data");
  //   try {
  //     token != null ? headers['Authorization'] = "$token" : null;
  //     Response response =
  //         await dio.post(url, data: data, options: Options(headers: headers));

  //     log('response=<${response.statusCode}');

  //     if (response.statusCode == 400) {
  //       log("postresponse ${response.data}");
  //       // Here you can handle the 404 error and its message
  //       String errorMessage = response.data[
  //           'message']; // Adjust 'message' to match your API response structure
  //       // Example of how to use the error message:
  //       print("Error: $errorMessage");
  //       // You can also throw an exception or return null or any other handling mechanism as per your app's logic
  //     }

  //     return response.data;
  //     // if (response.statusCode == 400) {
  //     //   log("postresponse${response.data}");
  //     //   return response.data;
  //     // }
  //   } catch (e) {
  //     log("eror ${e}");
  //   }
  // }
  Future postDioRequest({required Map data}) async {
    try {
      token != null ? headers['Authorization'] = "$token" : null;
      Response response =
          await dio.post(url, data: data, options: Options(headers: headers));

      return response.data;
    } on DioException catch (e) {
      throw e;
    }
  }

  Future putDioRequest({Map? data}) async {
    try {
      token != null ? headers['Authorization'] = "$token" : null;
      Response response =
          await dio.put(url, data: data, options: Options(headers: headers));

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (err) {
      throw err;
    }
  }

  Future putDioFormData({required FormData data}) async {
    try {
      // log("Put url  $url ");
      log("Put Dio Data $data");
      token != null ? headers['Authorization'] = "$token" : null;
      // log("Put Token=> $token");
      Response response =
          await dio.put(url, data: data, options: Options(headers: headers));

      // log("response status ${response.statusCode}");
      log("Put Method Response ${response.data}");

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (err) {
      log("post statusCode ${err.response?.statusCode.toString()}");
      log("post type ${err.response?.data.toString()} ");
    }
  }
}

errorHandler(String errorMessage) {
  log("dklgjdskgj;ldskjlg${errorMessage}");
}

class ApiUrl {
  static const baseUrl = "https://offers-listing-app-backend.vercel.app";
  static const getUser = "$baseUrl/user";
  static const getBrands = "$baseUrl/brand";
  static const getBrandsOffer = "$baseUrl/offer";

  static const getOffers = "$baseUrl/offer";
  static const getHomeOffers = "$baseUrl/home-offers";
  static const getMansOffers = "$baseUrl/offer?category=";
  static const getSavedOffers = "$baseUrl/saved-offers";
  static const sendOtp = "$baseUrl/otp";
  static const verifyOtp = "$baseUrl/otp";
  static const createUser = "$baseUrl/user";
  static const saveOffer = "$baseUrl/offer";
  static const grabDeal = "$baseUrl/offer";
  static const rating = "$baseUrl/rating";
}

Dio dio = Dio();

Future<void> fetchData(void Function(List<dynamic>) fun) async {
  try {
    final response =
        await dio.get("https://offers-listing-app-backend.vercel.app/brand");

    if (response.statusCode == 200) {
      // log("fatch Data=> ${response.data}");
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
      // log("Response=>>>>${response.data}");
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
