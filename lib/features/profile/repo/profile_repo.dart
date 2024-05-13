import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/utils/api_method.dart';
import 'package:rush/utils/secure_storage%20copy.dart';

final profileRepoProvider = Provider.autoDispose((ref) => ProfileRepo(ref));

class ProfileRepo {
  final AutoDisposeProviderRef<Object?> ref;

  ProfileRepo(this.ref);
  Future getProfile() async {
    try {
      final token =
          await ref.watch(secureStoargeProvider).readData('authToken');

      log("token=>>>>>>>>>>$token");

      final response =
          await ApiMethod(url: ApiUrl.getUser, token: token).getDioRequest();
      log(" Url =>${ApiUrl.getUser}");

      log("Profile Repo Response => $response");
      return response;
    } catch (err) {
      log("Profile Repo Error=> $err");
    }
  }
}



// final response = await ApiMethod(url: "${ApiUrl.getUser}${id}").getDioRequest();