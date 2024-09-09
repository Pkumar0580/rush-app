import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/utils/api_method.dart';

final brandRepoProvider = Provider((ref) => BrandRepo());

class BrandRepo {
  getBrands() async {
    try {
      final response = await ApiMethod(url: ApiUrl.getBrands).getDioRequest();
      return response;
    } catch (error) {
      log(error.toString());
    }
  }

  getBrandsCategory({String? category, String? subCategory}) async {
    try {
      String url = "${ApiUrl.getBrandsCategory}$category";
      if (subCategory != null && subCategory.isNotEmpty) {
        url += "&sub_category=$subCategory";
      }
      final response = await ApiMethod(url: url).getDioRequest();
      // log("Response=>$response");
      return response;
    } catch (error) {
      log("Error fetching brands: $error");
      return null;
    }
  }

  Future getBrendWithId(String id) async {
    try {
      final response =
          await ApiMethod(url: "${ApiUrl.getBrands}/$id").getDioRequest();
      return response;
    } catch (err) {
      log("Profile Repo Error=> $err");
    }
  }

  getBrandsOffers(String id) async {
    log("offerid$id");
    try {
      final response =
          ApiMethod(url: "${ApiUrl.getBrandsOffer}?brand=$id").getDioRequest();

      log("Response=>$response");
      return response;
    } catch (error) {
      log(error.toString());
    }
  }
}
