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



// final profileRepoProvider = Provider((ref) => ProfileRepo());

// class ProfileRepo {
//   Future getProfile() async {
//     try {
//       final response = await ApiMethod(url: ApiUrl.getUser).getDioRequest();

//       log("Profile Repo Response => ${response}");
//       return response.toString();
//     } catch (err) {
//       log("Profile Repo Error=> $err");
//     }
//   }
// }