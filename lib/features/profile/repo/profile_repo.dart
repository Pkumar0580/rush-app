import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/utils/api_method.dart';

final profileRepoProvider = Provider((ref) => ProfileRepo());

class ProfileRepo {
  Future getProfile() async {
    try {
      final response = await ApiMethod(url: ApiUrl.getUser).getDioRequest();

      log("Profile Repo Response => $response");
      return response;
    } catch (err) {
      log("Profile Repo Error=> $err");
    }
  }

 


}



// final response = await ApiMethod(url: "${ApiUrl.getUser}${id}").getDioRequest();