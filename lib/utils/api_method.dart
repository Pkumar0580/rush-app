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
        // log("Profile data=> ${response.data}");
        return response.data;
      }
    } on DioException {
      rethrow;
    }
  }

  Future postDioRequest({required Map data}) async {
    try {
      token != null ? headers['Authorization'] = "$token" : null;
      Response response =
          await dio.post(url, data: data, options: Options(headers: headers));

      return response.data;
    } on DioException {
      rethrow;
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
    } on DioException {
      rethrow;
    }
  }

  Future putDioFormData({required FormData data}) async {
    try {
      token != null ? headers['Authorization'] = "$token" : null;
      Response response =
          await dio.put(url, data: data, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (err) {
      log("post statusCode ${err.response?.statusCode.toString()}");
      log("post type ${err.response?.data.toString()} ");
    }
  }

  Future deleteDioRequest() async {
    try {
      token != null ? headers['Authorization'] = "$token" : null;
      Response response =
          await dio.delete(url, options: Options(headers: headers));
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
  log("Eroor$errorMessage");
}

class ApiUrl {
  static const baseUrl = "https://offers-listing-app-backend.vercel.app";
  static const getUser = "$baseUrl/user";
  static const getBrands = "$baseUrl/brand";
    static const getBrandsCategory = "$baseUrl/brand?category=";
  static const getBrandsOffer = "$baseUrl/offers";

  static const getOffers = "$baseUrl/offer";
  static const getHomeOffers = "$baseUrl/home-offers";
  static const getMansOffers = "$baseUrl/offers?category=";
  static const getSavedOffers = "$baseUrl/saved-offers";
  static const sendOtp = "$baseUrl/otp";
  static const verifyOtp = "$baseUrl/otp";
  static const createUser = "$baseUrl/user";
  static const deleteUser = "$baseUrl/user";
  static const saveOffer = "$baseUrl/offer";
  static const removeOffer = "$baseUrl/offer";
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
