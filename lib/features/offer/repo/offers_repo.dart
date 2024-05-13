import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/utils/api_method.dart';



final OffersRepoProvider=Provider((ref) => OffersRepo());

class OffersRepo {
 Future getOffers() async {
    try {
      final response = await ApiMethod(url: ApiUrl.getOffers).getDioRequest();

      log("Get Offer Response=>$response");
      return response;
    } catch (e) {
      log("Get Offer Error=> $e");
    }
  }
}



