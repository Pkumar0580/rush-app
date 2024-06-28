import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/utils/api_method.dart';

final brandRepoProvider = Provider((ref) => BrandRepo());

class BrandRepo {
  getBrands() async {
    try {
      final response = ApiMethod(url: ApiUrl.getBrands).getDioRequest();

      // log("Response=>$response");
      return response;
    } catch (error) {
      log(error.toString());
    }
  }

  Future getBrendWithId(String id) async {
    try {
      final response =
          await ApiMethod(url: "${ApiUrl.getBrands}/$id").getDioRequest();

      // log("Profile Repo Response => $response");
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
