import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/utils/api_method.dart';

final authRepoProvider = Provider((ref) => AuthRepo());

class AuthRepo {
  sendOtp(String mobile) async {
    try {
      final response = await ApiMethod(url: ApiUrl.sendOtp)
          .postDioRequest(data: {"phone_number": mobile});
      log("Send Otp Repo Response= $response");
      return response;
    } catch (error) {
      log("Send Otp Repo Error= $error");
    }
  }

  signIn({required String mobile, required String otp}) async {
    try {
      final response = await ApiMethod(url: ApiUrl.verifyOtp)
          .putDioRequest(data: {"phone_number": mobile, "otp": otp});

      log("SignIn Repo Response= $response");

      return response;
    } catch (err) {
      log("SignIn Repo Error= $err");
    }
  }
}
