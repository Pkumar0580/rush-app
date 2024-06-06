import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/utils/api_method.dart';

final OffersRepoProvider = Provider((ref) => OffersRepo());

class OffersRepo {
  Future getOffers() async {
    try {
      final response = await ApiMethod(url: ApiUrl.getOffers).getDioRequest();
      return response;
    } catch (e) {
      log("Get Offer Error=> $e");
    }
  }


  Future getOffersById({ required String id}) async {
    try {
      final response = await ApiMethod(url: "${ApiUrl.getOffers}/$id").getDioRequest();

    
      return response;
    } catch (e) {
      log("Get Offer Error=> $e");
    }
  }



}
